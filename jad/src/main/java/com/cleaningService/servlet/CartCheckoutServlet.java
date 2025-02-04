/* 
 * JAD-CA1
 * Class-DIT/FT/2A/23
 * Student Name: Moe Myat Thwe
 * Admin No.: P2340362
 */
package com.cleaningService.servlet;

import com.cleaningService.util.DBConnection;
import com.cleaningService.util.EmailUtil;

import jakarta.mail.MessagingException;
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
import java.util.Arrays;

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
            request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
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
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
                return;
            }
            
            System.out.println("Selected items for checkout: " + Arrays.toString(selectedItems));

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
                    double price = Double.parseDouble(item.get("price").toString());

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
                            "INSERT INTO bookings (userid,categoryid, serviceid, booking_date, booking_time, duration, service_address, special_request,status,total_price, created) " +
                                    "VALUES (?,?, ?, ?, ?, ?, ?, ?,'pending',?, CURRENT_TIMESTAMP)", 
                                    PreparedStatement.RETURN_GENERATED_KEYS)) {
                        stmt.setInt(1, userId);
                        stmt.setInt(2, categoryId);
                        stmt.setInt(3, serviceId);
                        stmt.setDate(4, sqlDate); // Use java.sql.Date
                        stmt.setTime(5, sqlTime);
                        stmt.setInt(6, duration);
                        stmt.setString(7, address);
                        stmt.setString(8, specialRequest);
                        stmt.setDouble(9, price);
                        stmt.executeUpdate();
                        
                        System.out.println("Booking inserted successfully for service ID: " + serviceId);
                     // Retrieve the booking ID (for logging and future updates)
                        try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                int bookingId = generatedKeys.getInt(1);
                                System.out.println("Booking ID created: " + bookingId);
                            }
                        }
             
                    } catch (SQLException e) {
                        e.printStackTrace();
                        allSuccess = false;
                        break;
                    }
                }

                if (allSuccess) {
                	// Send the invoice email
                    String userEmail = getUserEmail(userId, conn);
                    if (userEmail != null) {
                        String invoiceContent = generateInvoice(cart);
                        EmailUtil.sendEmail(userEmail, "Your Invoice from Shiny Cleaning Services", invoiceContent);

                        // Update the status to "confirmed"
                        updateBookingStatusToConfirmed(userId, conn);
                    }
                    session.removeAttribute("cart");
                    response.sendRedirect(request.getContextPath() + "/jsp/serviceHistory.jsp");
                } else {
                    request.setAttribute("error", "Failed to process booking.");
                    request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);

                }
            } catch (SQLException | MessagingException e) {
                e.printStackTrace();
                request.setAttribute("error", "Database connection failed.");
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);

            }

        }
    }
    
    private String getUserEmail(int userId, Connection conn) throws SQLException {
        String email = null;
        try (PreparedStatement stmt = conn.prepareStatement("SELECT email FROM users WHERE id = ?")) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    email = rs.getString("email");
                }
            }
        }
        return email;
    }

    private String generateInvoice(List<Map<String, Object>> cart) {
        StringBuilder invoice = new StringBuilder();
        invoice.append("Dear Customer,\n\n");
        invoice.append("Thank you for your booking with Shiny Cleaning Services.\n\n");
        invoice.append("Here are your service details:\n");

        double totalAmount = 0.0;
        for (Map<String, Object> item : cart) {
            String serviceName = item.get("serviceName").toString();
            double price = Double.parseDouble(item.get("price").toString());
            totalAmount += price;

            invoice.append("Service: ").append(serviceName).append("\n");
            invoice.append("Price: $").append(String.format("%.2f", price)).append("\n\n");
        }

        double gst = totalAmount * 0.07; // 7% GST
        double finalAmount = totalAmount + gst;

        invoice.append("Subtotal: $").append(String.format("%.2f", totalAmount)).append("\n");
        invoice.append("GST (7%): $").append(String.format("%.2f", gst)).append("\n");
        invoice.append("Total Amount: $").append(String.format("%.2f", finalAmount)).append("\n");
        invoice.append("\nThank you for choosing us!\n\nRegards,\nShiny Cleaning Services");

        return invoice.toString();
    }

    private void updateBookingStatusToConfirmed(int userId, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(
                "UPDATE bookings SET status = 'confirmed' WHERE userid = ? AND status = 'pending'")) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        }
    }
}
