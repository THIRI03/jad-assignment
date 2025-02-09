/*-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--*/
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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.cleaningService.dao.BookingDAO;
import com.cleaningService.model.Booking;
import com.cleaningService.util.EmailUtil;
import com.cleaningService.util.AuthUtil;
import com.cleaningService.util.DBConnection;

@WebServlet("/ConfirmCheckoutServlet")
public class ConfirmCheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Step 1: Authentication check
        if (!AuthUtil.checkAuthentication(request, response)) {
            return;  // If not authenticated, redirect to login.jsp is already handled
        }

        HttpSession session = request.getSession();
        List<Map<String, Object>> selectedCartItems = (List<Map<String, Object>>) session.getAttribute("selectedCartItems");

        if (selectedCartItems == null || selectedCartItems.isEmpty()) {
            response.getWriter().write("No items available for checkout.");
            return;
        }

     // Step 2: Save bookings to the database
        BookingDAO bookingDAO = new BookingDAO();

        double subtotal = 0.0;
        double totalDiscountAmount = 0.0;

        try (Connection conn = DBConnection.getConnection()) {
            for (Map<String, Object> item : selectedCartItems) {
                Booking booking = new Booking();

                if (item.containsKey("serviceId") && item.containsKey("categoryId")) {
                    booking.setServiceId(Integer.parseInt(item.get("serviceId").toString()));
                    booking.setCategoryId(Integer.parseInt(item.get("categoryId").toString()));
                } else {
                    response.getWriter().write("Service or Category ID is missing for booking: " + item.get("serviceName"));
                    return;
                }

                booking.setServiceName((String) item.get("serviceName"));
                booking.setDuration(Integer.parseInt(item.get("duration").toString()));
                double itemPrice = Double.parseDouble(item.get("price").toString().replace("$", ""));

                // Query to get the best applicable discount
                String discountQuery = """
                    SELECT name, discount_rate 
                    FROM Discount
                    WHERE status = 'Active'
                    AND (service_id = ? OR category_id = ? OR (service_id IS NULL AND category_id IS NULL))
                    AND CURRENT_DATE BETWEEN start_date AND end_date
                    ORDER BY 
                        (service_id = ?) DESC,
                        (category_id = ?) DESC
                    LIMIT 1
                """;

                double discountRate = 0.0;
                try (PreparedStatement pstmt = conn.prepareStatement(discountQuery)) {
                    pstmt.setInt(1, booking.getServiceId());
                    pstmt.setInt(2, booking.getCategoryId());
                    pstmt.setInt(3, booking.getServiceId());
                    pstmt.setInt(4, booking.getCategoryId());

                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            discountRate = rs.getDouble("discount_rate");
                        }
                    }
                }
             // Apply discount and calculate prices
                double discountAmount = itemPrice * discountRate / 100;
                double discountedPrice = itemPrice - discountAmount;

                subtotal += discountedPrice;
                totalDiscountAmount += discountAmount;

                booking.setTotalPrice(discountedPrice);
                booking.setDate((String) item.get("date"));
                booking.setTime((String) item.get("time"));
                booking.setServiceAddress((String) item.get("serviceAddress"));
                booking.setSpecialRequest((String) item.get("specialRequest"));
                booking.setStatus("Not Completed");

                Object userIdObj = session.getAttribute("userId");
                if (userIdObj instanceof Integer) {
                    booking.setUserId((Integer) userIdObj);
                } else {
                    response.getWriter().write("Invalid user session.");
                    return;
                }

                if (!bookingDAO.createBooking(booking)) {
                    response.getWriter().write("Failed to save booking for service: " + booking.getServiceName());
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Error applying discounts: " + e.getMessage());
            return;
        }


        // Step 4: Calculate GST and final total
        double gst = subtotal * 0.09;
        double finalAmount = subtotal + gst;

        // Step 5: Clear cart after successful checkout
        session.removeAttribute("cart");

        // Step 6: Send confirmation email
        String userEmail = (String) session.getAttribute("userEmail");

        try {
            // Generate email content with the dynamic amounts
        	String emailContent = generateInvoiceEmail(selectedCartItems, subtotal, gst, totalDiscountAmount, finalAmount);

            // Send the email
            EmailUtil.sendEmail(userEmail, "Payment Confirmation", emailContent);

            System.out.println("DEBUG: Email sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Failed to send email: " + e.getMessage());
            return;
        }



        // Step 7: Display success message
        response.setContentType("text/html");

        response.getWriter().write("<html>");
        response.getWriter().write("<head>");
        response.getWriter().write("<title>Payment Successful</title>");
        response.getWriter().write("<link rel='stylesheet' type='text/css' href='" + request.getContextPath() + "/css/checkout.css'>");
        response.getWriter().write("</head>");
        response.getWriter().write("<body>");
        response.getWriter().write("<div class='confirmation-container'>");
        response.getWriter().write("<h1>Payment Successful</h1>");
        response.getWriter().write("<p>You have booked an appointment successfully.</p>");
        response.getWriter().write("<p>A confirmation email has been sent to " + userEmail + ".</p>");
        response.getWriter().write("<a href='" + request.getContextPath() + "/jsp/home.jsp'>Go to Home</a>");
        response.getWriter().write("</div>");
        response.getWriter().write("</body>");
        response.getWriter().write("</html>");
    }

    private String generateInvoiceEmail(List<Map<String, Object>> cart, double subtotal, double gst, double discount, double finalAmount) {
        StringBuilder invoice = new StringBuilder();
        invoice.append("<html><body>");
        invoice.append("<h1 style='color:purple;'>Payment Confirmation</h1>");
        invoice.append("<p>Thank you for using Shiny Cleaning Services! Here are your booking details:</p>");
        invoice.append("<table border='1' cellpadding='8' cellspacing='0' style='border-collapse:collapse; width:100%;'>");
        invoice.append("<tr style='background-color:#f2f2f2;'><th>Service</th><th>Price</th><th>Discount Applied</th><th>Date</th><th>Time</th></tr>");

        for (Map<String, Object> item : cart) {
            String serviceName = item.get("serviceName").toString();
            String price = item.get("price").toString();
            String date = item.get("date").toString();
            String time = item.get("time").toString();

            double itemPrice = Double.parseDouble(price.replace("$", ""));
            double itemDiscountRate = item.containsKey("discountRate") ? (double) item.get("discountRate") : 0.0;
            double itemDiscountAmount = itemPrice * itemDiscountRate / 100;

            invoice.append("<tr>");
            invoice.append("<td>").append(serviceName).append("</td>");
            invoice.append("<td>$").append(String.format("%.2f", itemPrice)).append("</td>");
            invoice.append("<td style='color:green;'>")
                   .append(itemDiscountRate > 0 ? String.format("%.1f%% ($%.2f)", itemDiscountRate, itemDiscountAmount) : "No Discount")
                   .append("</td>");
            invoice.append("<td>").append(date).append("</td>");
            invoice.append("<td>").append(time).append("</td>");
            invoice.append("</tr>");
        }

        invoice.append("</table>");
        invoice.append("<br>");
        invoice.append("<div style='margin-top:20px; font-size:16px;'>");
        invoice.append("<p>Subtotal: $").append(String.format("%.2f", subtotal)).append("</p>");
        invoice.append("<p>GST (9%): $").append(String.format("%.2f", gst)).append("</p>");
        invoice.append("<p><strong>Total Amount: $").append(String.format("%.2f", finalAmount)).append("</strong></p>");
        invoice.append("</div>");
        invoice.append("<p>We look forward to serving you again!</p>");
        invoice.append("</body></html>");

        return invoice.toString();
    }

}
