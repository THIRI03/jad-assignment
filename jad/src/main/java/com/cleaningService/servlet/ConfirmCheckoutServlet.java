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

@WebServlet("/ConfirmCheckoutServlet")
public class ConfirmCheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Map<String, Object>> selectedCartItems = (List<Map<String, Object>>) session.getAttribute("selectedCartItems");

        if (selectedCartItems == null || selectedCartItems.isEmpty()) {
            response.getWriter().write("No items available for checkout.");
            return;
        }

        // Save bookings to the database
        BookingDAO bookingDAO = new BookingDAO();
        for (Map<String, Object> item : selectedCartItems) {
        	Booking booking = new Booking();
        	
        	// Fetch and validate serviceId and categoryId
            if (item.containsKey("serviceId") && item.containsKey("categoryId")) {
                booking.setServiceId(Integer.parseInt(item.get("serviceId").toString()));
                booking.setCategoryId(Integer.parseInt(item.get("categoryId").toString()));
            } else {
                response.getWriter().write("Service or Category ID is missing for booking: " + item.get("serviceName"));
                return;
            }
            
        	booking.setServiceId(Integer.parseInt(item.get("serviceId").toString()));      
            booking.setServiceName((String) item.get("serviceName"));
            booking.setTotalPrice(Double.parseDouble(item.get("price").toString().replace("$", "")));
            booking.setDate((String) item.get("date"));
            booking.setTime((String) item.get("time"));
            booking.setServiceAddress((String) item.get("serviceAddress"));
            booking.setSpecialRequest((String) item.get("specialRequest"));
            booking.setUserId((Integer) session.getAttribute("userId"));

         // Get userId from session and set it
            Object userIdObj = session.getAttribute("userId");
            if (userIdObj instanceof String) {
                booking.setUserId(Integer.parseInt((String) userIdObj));
            } else if (userIdObj instanceof Integer) {
                booking.setUserId((Integer) userIdObj);
            }

            // Save booking
            if (!bookingDAO.createBooking(booking)) {
                response.getWriter().write("Failed to save booking for service: " + booking.getServiceName());
                return;
            }
        }

        // Clear cart after successful checkout
        session.removeAttribute("cart");

        // Send confirmation email
        String userEmail = (String) session.getAttribute("userEmail");
        try {
            String emailContent = generateInvoiceEmail(selectedCartItems);
            EmailUtil.sendEmail(userEmail, "Booking Confirmation", emailContent);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Failed to send email: " + e.getMessage());
            return;
        }


        // Display a confirmation message to the user
        response.setContentType("text/html");
        response.getWriter().write("<html><body>");
        response.getWriter().write("<h1>Checkout Successful</h1>");
        response.getWriter().write("<p>Your booking has been confirmed. A confirmation email has been sent to " + userEmail + ".</p>");
        response.getWriter().write("<a href='" + request.getContextPath() + "/home.jsp'>Go to Home</a>");
        response.getWriter().write("</body></html>");
    }

 // Generate an HTML email for the invoice
    private String generateInvoiceEmail(List<Map<String, Object>> cart) {
        StringBuilder invoice = new StringBuilder();
        invoice.append("<html><body>");
        invoice.append("<h1>Booking Confirmation</h1>");
        invoice.append("<p>Thank you for your booking with Shiny Cleaning Services!</p>");
        invoice.append("<table border='1' cellpadding='8' cellspacing='0'>");
        invoice.append("<tr><th>Service</th><th>Price</th></tr>");

        double totalAmount = 0.0;
        for (Map<String, Object> item : cart) {
            String serviceName = item.get("serviceName").toString();
            double price = Double.parseDouble(item.get("price").toString().replace("$", ""));
            totalAmount += price;

            invoice.append("<tr>");
            invoice.append("<td>").append(serviceName).append("</td>");
            invoice.append("<td>$").append(String.format("%.2f", price)).append("</td>");
            invoice.append("</tr>");
        }

        double gst = totalAmount * 0.07;
        double finalAmount = totalAmount + gst;

        invoice.append("</table>");
        invoice.append("<p>Subtotal: $").append(String.format("%.2f", totalAmount)).append("</p>");
        invoice.append("<p>GST (7%): $").append(String.format("%.2f", gst)).append("</p>");
        invoice.append("<p><strong>Total Amount: $").append(String.format("%.2f", finalAmount)).append("</strong></p>");
        invoice.append("<p>Thank you for choosing us!</p>");
        invoice.append("</body></html>");

        return invoice.toString();
    }
}