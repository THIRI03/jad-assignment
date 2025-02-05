/*-- 
    JAD-CA1
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
import java.util.List;
import java.util.Map;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

        if (cart == null) {
            cart = new java.util.ArrayList<>();
        }

        // Handle remove action
        String removeIndexStr = request.getParameter("remove");
        if (removeIndexStr != null) {
            try {
                int removeIndex = Integer.parseInt(removeIndexStr);
                if (removeIndex >= 0 && removeIndex < cart.size()) {
                    cart.remove(removeIndex);
                    session.setAttribute("cart", cart);
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid item index.");
            }
        }

        // Check if the request is an AJAX request
        String isAjax = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(isAjax)) {
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/jsp/cartItemsFragment.jsp").forward(request, response);
        } else {
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/jsp/cart.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
