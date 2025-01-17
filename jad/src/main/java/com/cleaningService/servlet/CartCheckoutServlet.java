/* 
 * JAD-CA1
 * Class-DIT/FT/2A/23
 * Student Name: Moe Myat Thwe
 * Admin No.: P2340362
 */
package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.cleaningService.util.DBConnection;

@WebServlet("/CartCheckoutServlet")
public class CartCheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("/jsp/login.jsp");
            return;
        }

        // Retrieve the cart from the session
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Your cart is empty.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        // Handle item removal
        if (request.getParameter("remove") != null) {
            int removeIndex = Integer.parseInt(request.getParameter("remove"));
            if (removeIndex >= 0 && removeIndex < cart.size()) {
                cart.remove(removeIndex);
                session.setAttribute("cart", cart); // Update the session
            }
            response.sendRedirect(request.getContextPath() + "/jsp/cart.jsp");

            return;
        }

        // Handle checkout
        if (request.getParameter("checkout") != null) {
            String[] selectedItems = request.getParameterValues("selectedItems");

            if (selectedItems == null || selectedItems.length == 0) {
                request.setAttribute("error", "No items selected for checkout.");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            try (Connection conn = DBConnection.getConnection()) {
                boolean allSuccess = true;

                for (String index : selectedItems) {
                    int itemIndex = Integer.parseInt(index);
                    Map<String, Object> item = cart.get(itemIndex);

                    int categoryId = Integer.parseInt(item.get("categoryId").toString());
                    int serviceId = Integer.parseInt(item.get("serviceId").toString());
                    String dateString = item.get("date").toString();
                    String timeString = item.get("time").toString();
                    int duration = Integer.parseInt(item.get("duration").toString());
                    String address = item.get("serviceAddress").toString();
                    String specialRequest = item.get("specialRequest").toString();

                    // Convert date string to java.sql.Date
                    java.sql.Date sqlDate = java.sql.Date.valueOf(dateString); // Use Date.valueOf for yyyy-MM-dd format
                    java.sql.Time sqlTime;
                    if (timeString != null && !timeString.trim().isEmpty()) {
                        if (timeString.length() == 5) { // Format is HH:mm
                            timeString += ":00"; // Append seconds
                        }
                        sqlTime = java.sql.Time.valueOf(timeString);
                    } else {
                        throw new IllegalArgumentException("Invalid time value: " + timeString);
                    }
                    try (PreparedStatement stmt = conn.prepareStatement(
                            "INSERT INTO booking (user_id,category_id, service_id, date, time, duration, service_address, special_request, created_at) " +
                                    "VALUES (?,?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)")) {
                        stmt.setInt(1, userId);
                        stmt.setInt(2, categoryId);
                        stmt.setInt(3, serviceId);
                        stmt.setDate(4, sqlDate); // Use java.sql.Date
                        stmt.setTime(5, sqlTime);
                        stmt.setInt(6, duration);
                        stmt.setString(7, address);
                        stmt.setString(8, specialRequest);
                        stmt.executeUpdate();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        allSuccess = false;
                        break;
                    }
                }

                if (allSuccess) {
                    session.removeAttribute("cart");
                    response.sendRedirect(request.getContextPath() + "/jsp/serviceHistory.jsp");
                } else {
                    request.setAttribute("error", "Failed to process booking.");
                    request.getRequestDispatcher("cart.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database connection failed.");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }

        }
    }
}
