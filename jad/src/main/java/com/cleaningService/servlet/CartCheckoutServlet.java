/* 
 * JAD-CA1
 * Class-DIT/FT/2A/23
 * Student Name: Moe Myat Thwe
 * Admin No.: P2340362
 */
package com.cleaningService.servlet;

import com.cleaningService.dao.BookingDAO;
import com.cleaningService.model.Booking;
import com.cleaningService.util.EmailUtil;

import jakarta.mail.MessagingException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/CartCheckoutServlet")
public class CartCheckoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Redirect to login if user is not authenticated
        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        // Retrieve the cart from session
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("error", "Your cart is empty.");
            request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            return;
        }

        // Get selected items from the form
        String[] selectedItems = request.getParameterValues("selectedItems");
        if (selectedItems == null || selectedItems.length == 0) {
            request.setAttribute("error", "No items selected for checkout.");
            request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            return;
        }

        // Create BookingDAO for booking operations
        BookingDAO bookingDAO = new BookingDAO();
        boolean allSuccess = true;

        // Process each selected item (simplified for testing)
        for (String indexStr : selectedItems) {
            try {
                int itemIndex = Integer.parseInt(indexStr);
                if (itemIndex < 0 || itemIndex >= cart.size()) {
                    throw new IndexOutOfBoundsException("Invalid cart item index.");
                }

                Map<String, Object> item = cart.get(itemIndex);

                // Create booking object
                Booking booking = new Booking();
                booking.setUserId(userId);
                booking.setCategoryId(Integer.parseInt(item.get("categoryId").toString()));
                booking.setServiceId(Integer.parseInt(item.get("serviceId").toString()));
                booking.setDate(item.get("date").toString());
                booking.setTime(item.get("time").toString());
                booking.setDuration(Integer.parseInt(item.get("duration").toString()));
                booking.setServiceAddress(item.get("serviceAddress").toString());
                booking.setSpecialRequest(item.get("specialRequest").toString());
                booking.setTotalPrice(Double.parseDouble(item.get("price").toString()));

                // Save booking to the database
                if (!bookingDAO.createBooking(booking)) {
                    allSuccess = false;
                    break;
                }

            } catch (Exception e) {
                e.printStackTrace();
                allSuccess = false;
                break;
            }
        }

        if (allSuccess) {
            try {
                // Send confirmation email with invoice
                String userEmail = bookingDAO.getUserEmail(userId);
                if (userEmail != null) {
                    String invoiceContent = generateInvoice(cart);
                    EmailUtil.sendEmail(userEmail, "Your Invoice from Shiny Cleaning Services", invoiceContent);
                }

                // Clear the cart after successful checkout
                session.removeAttribute("cart");
                response.sendRedirect(request.getContextPath() + "/jsp/serviceHistory.jsp");
            } catch (MessagingException e) {
                e.printStackTrace();
                request.setAttribute("error", "Failed to send confirmation email.");
                request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Failed to process booking.");
            request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
        }
    }

    /**
     * Generates an invoice for the selected services.
     * @param cart The cart containing the services.
     * @return The invoice as a string.
     */
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

        double gst = totalAmount * 0.07;  // 7% GST
        double finalAmount = totalAmount + gst;

        invoice.append("Subtotal: $").append(String.format("%.2f", totalAmount)).append("\n");
        invoice.append("GST (7%): $").append(String.format("%.2f", gst)).append("\n");
        invoice.append("Total Amount: $").append(String.format("%.2f", finalAmount)).append("\n");
        invoice.append("\nThank you for choosing us!\n\nRegards,\nShiny Cleaning Services");

        return invoice.toString();
    }
}