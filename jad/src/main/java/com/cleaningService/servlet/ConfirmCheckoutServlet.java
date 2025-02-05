package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
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
                        
            booking.setServiceName((String) item.get("serviceName"));
            booking.setTotalPrice(Double.parseDouble(item.get("price").toString().replace("$", "")));
            booking.setDate((String) item.get("date"));
            booking.setTime((String) item.get("time"));
            booking.setServiceAddress((String) item.get("serviceAddress"));
            booking.setSpecialRequest((String) item.get("specialRequest"));

         // Fix the userId cast issue
            Object userIdObj = session.getAttribute("userId");
            if (userIdObj instanceof String) {
                booking.setUserId(Integer.parseInt((String) userIdObj));
            } else if (userIdObj instanceof Integer) {
                booking.setUserId((Integer) userIdObj);
            }

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
            EmailUtil.sendEmail(userEmail, "Booking Confirmation", generateInvoice(selectedCartItems));
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

    private String generateInvoice(List<Map<String, Object>> cart) {
        StringBuilder invoice = new StringBuilder();
        invoice.append("Dear Customer,\n\n");
        invoice.append("Thank you for your booking with Shiny Cleaning Services.\n\n");
        invoice.append("Here are your service details:\n");

        double totalAmount = 0.0;
        for (Map<String, Object> item : cart) {
            String serviceName = item.get("serviceName").toString();
            double price = Double.parseDouble(item.get("price").toString().replace("$", ""));
            totalAmount += price;

            invoice.append("Service: ").append(serviceName).append("\n");
            invoice.append("Price: $").append(String.format("%.2f", price)).append("\n\n");
        }

        double gst = totalAmount * 0.07;
        double finalAmount = totalAmount + gst;

        invoice.append("Subtotal: $").append(String.format("%.2f", totalAmount)).append("\n");
        invoice.append("GST (7%): $").append(String.format("%.2f", gst)).append("\n");
        invoice.append("Total Amount: $").append(String.format("%.2f", finalAmount)).append("\n");
        invoice.append("\nThank you for choosing us!\n\nRegards,\nShiny Cleaning Services");

        return invoice.toString();
    }
}
