package com.cleaningService.servlet;

import com.cleaningService.util.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
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

        session.setAttribute("selectedCartItems", selectedCartItems);
     // Step 5: Forward to the cartCheckout page
        request.getRequestDispatcher("/jsp/cartCheckout.jsp").forward(request, response);
    }
}
