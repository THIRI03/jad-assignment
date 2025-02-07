package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.cleaningService.dao.BookingDAO;
import com.cleaningService.model.Booking;
import com.cleaningService.util.EmailUtil;
import com.cleaningService.util.AuthUtil;

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
            booking.setTotalPrice(Double.parseDouble(item.get("price").toString().replace("$", "")));
            booking.setDate((String) item.get("date"));
            booking.setTime((String) item.get("time"));
            booking.setServiceAddress((String) item.get("serviceAddress"));
            booking.setSpecialRequest((String) item.get("specialRequest"));

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

        // Step 3: Clear cart after successful checkout
        session.removeAttribute("cart");

        // Step 4: Send confirmation email
        String userEmail = (String) session.getAttribute("userEmail");

        try {
            // Prepare email content
            double subtotal = 90.0;  // Replace with actual subtotal from cart
            double gst = subtotal * 0.07;
            double discount = subtotal * 0.10;
            double finalAmount = subtotal + gst - discount;

            String emailContent = generateInvoiceEmail(selectedCartItems, subtotal, gst, discount, finalAmount);

            // Send the email
            EmailUtil.sendEmail(userEmail, "Payment Confirmation", emailContent);

            System.out.println("DEBUG: Email sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Failed to send email: " + e.getMessage());
            return;
        }

        // Step 5: Display success message
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
        invoice.append("<h1>Payment Confirmation</h1>");
        invoice.append("<p>Thank you for using Shiny Cleaning Services! Here are your booking details:</p>");
        invoice.append("<table border='1' cellpadding='8' cellspacing='0'>");
        invoice.append("<tr><th>Service</th><th>Price</th><th>Date</th><th>Time</th></tr>");

        for (Map<String, Object> item : cart) {
            String serviceName = item.get("serviceName").toString();
            String price = item.get("price").toString();
            String date = item.get("date").toString();
            String time = item.get("time").toString();

            invoice.append("<tr>");
            invoice.append("<td>").append(serviceName).append("</td>");
            invoice.append("<td>").append(price).append("</td>");
            invoice.append("<td>").append(date).append("</td>");
            invoice.append("<td>").append(time).append("</td>");
            invoice.append("</tr>");
        }

        invoice.append("</table>");
        invoice.append("<p>Subtotal: $").append(String.format("%.2f", subtotal)).append("</p>");
        invoice.append("<p>GST (7%): $").append(String.format("%.2f", gst)).append("</p>");
        invoice.append("<p>Discount: $").append(String.format("%.2f", discount)).append("</p>");
        invoice.append("<p><strong>Total Amount: $").append(String.format("%.2f", finalAmount)).append("</strong></p>");
        invoice.append("<p>We look forward to serving you again!</p>");
        invoice.append("</body></html>");

        return invoice.toString();
    }
}
