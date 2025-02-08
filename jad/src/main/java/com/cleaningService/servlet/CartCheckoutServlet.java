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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@WebServlet("/CartCheckoutServlet")
public class CartCheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 // Step 1: Authentication check
        if (!AuthUtil.checkAuthentication(request, response)) {
            return;  // If not authenticated, redirect to login.jsp is already handled
        }

        // Step 2: Retrieve cart from session
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/jsp/cart.jsp");
            return;
        }

        // Step 3: Handle selected items for checkout
        String[] selectedItems = request.getParameterValues("selectedItems");
        if (selectedItems == null || selectedItems.length == 0) {
            request.setAttribute("error", "No items selected for checkout.");
            request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            return;
        }
     // Step 4: Filter selected items and set them in the session
        List<Map<String, Object>> selectedCartItems = new ArrayList<>();
        for (String indexStr : selectedItems) {
            try {
                int index = Integer.parseInt(indexStr);
                if (index >= 0 && index < cart.size()) {
                    selectedCartItems.add(cart.get(index));
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
     // Fetch and apply discounts
        try (Connection conn = DBConnection.getConnection()) {
            for (Map<String, Object> item : selectedCartItems) {
                int serviceId = Integer.parseInt(item.get("serviceId").toString());
                int categoryId = Integer.parseInt(item.get("categoryId").toString());

                String discountQuery = """
                    SELECT name, description, discount_rate
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
                            double discountRate = rs.getDouble("discount_rate");
                            item.put("discountRate", discountRate);
                            item.put("discountName", rs.getString("name"));
                            item.put("discountDescription", rs.getString("description"));
                        } else {
                            item.put("discountRate", 0.0);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }


        session.setAttribute("selectedCartItems", selectedCartItems);
     // Step 5: Forward to the cartCheckout page
        request.getRequestDispatcher("/jsp/cartCheckout.jsp").forward(request, response);
    }
}
