/*-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--*/

package com.cleaningService.servlet;

import com.cleaningService.util.AuthUtil;
import com.cleaningService.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Step 1: Authentication check
        if (!AuthUtil.checkAuthentication(request, response)) {
            return;  // If not authenticated, redirect to login.jsp is already handled
        }
        
     // Step 2: Retrieve cart from session
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new java.util.ArrayList<>();
        }

     // Step 3: Fetch discount details for each item in the cart
        try (Connection conn = DBConnection.getConnection()) {
            for (Map<String, Object> item : cart) {
                int serviceId = Integer.parseInt(item.get("serviceId").toString());
                int categoryId = Integer.parseInt(item.get("categoryId").toString());

                String discountQuery = """
                    SELECT name, description, discount_rate, end_date
                    FROM Discount
                    WHERE status = 'Active'
                    AND (service_id = ? OR category_id = ? OR (service_id IS NULL AND category_id IS NULL))
                    AND CURRENT_DATE BETWEEN start_date AND end_date
                    ORDER BY 
                        (service_id = ?) DESC,
                        (category_id = ?) DESC
                    LIMIT 1
                """;

                try (PreparedStatement pstmt = conn.prepareStatement(discountQuery)) {
                    pstmt.setInt(1, serviceId);
                    pstmt.setInt(2, categoryId);
                    pstmt.setInt(3, serviceId);
                    pstmt.setInt(4, categoryId);

                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            item.put("discountName", rs.getString("name"));
                            item.put("discountDescription", rs.getString("description"));
                            item.put("discountRate", rs.getDouble("discount_rate"));
                            item.put("discountEndDate", rs.getDate("end_date").toString());
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        
        // Step 4: Handle remove action
        String removeIndexStr = request.getParameter("remove");
        if (removeIndexStr != null) {
            try {
                int removeIndex = Integer.parseInt(removeIndexStr);
                if (removeIndex >= 0 && removeIndex < cart.size()) {
                    cart.remove(removeIndex);
                    session.setAttribute("cart", cart);
                }
             // Check if the request is an AJAX request
                String isAjax = request.getHeader("X-Requested-With");
                if ("XMLHttpRequest".equals(isAjax)) {
                    response.setContentType("text/html");
                    response.getWriter().write(generateCartHtml(cart, request.getContextPath()));
                    return;
                }

                // Non-AJAX request fallback
                response.sendRedirect(request.getContextPath() + "/jsp/cart.jsp");
                return;
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid item index.");
            }
        }

     // Step 4: Forward to cart.jsp for normal page load
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
    }

    
    private String generateCartHtml(List<Map<String, Object>> cart, String contextPath) {
        StringBuilder html = new StringBuilder();

        html.append("<h1 class='cart-header'>My Cart</h1>");

        if (cart.isEmpty()) {
            html.append("<p class='empty-cart'>Your cart is empty.</p>");
            return html.toString();
        }

        try (Connection conn = DBConnection.getConnection()) {
            for (int i = 0; i < cart.size(); i++) {
                Map<String, Object> item = cart.get(i);
                int serviceId = Integer.parseInt(item.get("serviceId").toString());
                int categoryId = Integer.parseInt(item.get("categoryId").toString());
                String serviceName = (String) item.get("serviceName");
                String imagePath = (String) item.getOrDefault("imagePath", "images/default-placeholder.png");
                String price = item.getOrDefault("price", "0.00").toString();

             // Declare variables to hold discount details
                String discountMessage = "";
                String discountEndDate = "";
               
             // Fetch the applicable discount details
                String discountQuery = """
                	    SELECT d.name, d.description, d.discount_rate, d.end_date
                	    FROM Discount d
                	    LEFT JOIN service s ON d.service_id = s.id
                	    LEFT JOIN category c ON d.category_id = c.id
                	    WHERE d.status = 'Active'
                	    AND (d.service_id = ? OR d.category_id = ? OR (d.service_id IS NULL AND d.category_id IS NULL))
                	    AND CURRENT_DATE BETWEEN d.start_date AND d.end_date
                	    ORDER BY 
                	        (d.service_id = ?) DESC,  -- Prioritize service-specific discounts
                	        (d.category_id = ?) DESC, -- Then category-specific discounts
                	        d.id ASC                  -- Fallback for general discounts
                	    LIMIT 1
                	""";

                try (PreparedStatement pstmt = conn.prepareStatement(discountQuery)) {
                    pstmt.setInt(1, serviceId);
                    pstmt.setInt(2, categoryId);
                    pstmt.setInt(3, serviceId);
                    pstmt.setInt(4, categoryId);

                    try (ResultSet rs = pstmt.executeQuery()) {
                    	if (rs.next()) {
                    	    String discountName = rs.getString("name");
                    	    String discountDescription = rs.getString("description");
                    	    double discountRate = rs.getDouble("discount_rate");
                    	    discountEndDate = rs.getDate("end_date").toString();

                    	    discountMessage = String.format(
                    	        "Enjoy %.0f%% Off with \"%s\": %s (Valid until %s)",
                    	        discountRate, discountName, discountDescription, discountEndDate
                    	    );
                    	} else {
                    	    System.out.println("DEBUG: No discount found for serviceId=" + serviceId + ", categoryId=" + categoryId);
                    	}
                    }
                }

                // Build HTML for each cart item
                html.append("<div class='cart-item'>")
                    .append("<div class='cart-item-left'>")
                    .append("<input type='checkbox' name='selectedItems' value='").append(i).append("' class='cart-checkbox'>")
                    .append("<div class='cart-item-image'>")
                    .append("<img src='").append(contextPath).append("/").append(imagePath).append("' alt='").append(serviceName).append("'>")
                    .append("</div></div>")
                    .append("<div class='cart-item-details'>")
                    .append("<h2>").append(serviceName).append("</h2>")
                    .append("<p class='cart-price'>$").append(price).append("</p>");

                // Display discount message if available
                if (!discountMessage.isEmpty()) {
                    html.append("<div class='discount-info'>")
                        .append("<p class='discount-message'>").append(discountMessage).append("</p>")
                        .append("</div>");
                }

                html.append("</div>")
                    .append("<div class='cart-item-right'>")
                    .append("<button type='button' onclick='removeFromCart(").append(i).append(")' class='remove-btn'>Remove from Cart</button>")
                    .append("</div></div>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            html.append("<p class='error-message'>Error loading discounts: ").append(e.getMessage()).append("</p>");
        }

        html.append("<form action='").append(contextPath).append("/CartCheckoutServlet' method='POST' onsubmit='validateCheckout(event)'>")
            .append("<button type='submit' class='checkout-btn'>Checkout</button>")
            .append("</form>");

        return html.toString();
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
