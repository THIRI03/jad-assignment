package com.cleaningService.servlet;

import java.io.IOException;
import java.util.List;

import com.cleaningService.dao.CategoryDAO;
import com.cleaningService.model.Category;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CategoryServlet
 */
@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO;

    @Override
	public void init() {
        categoryDAO = new CategoryDAO();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fetchParam = request.getParameter("fetch");

        // If fetch parameter is not set, display a default error or redirect
        if (fetchParam == null || !fetchParam.equals("true")) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }

        // Proceed to retrieve categories
        List<Category> categories = categoryDAO.getAllCategory();

        if (categories == null || categories.isEmpty()) {
            System.out.println("DEBUG: No categories found!");
        } else {
            System.out.println("DEBUG: Categories retrieved: " + categories.size());
        }

        // Store categories in request scope
        request.setAttribute("categories", categories);

        // Forward request to categories.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/categories.jsp");
        dispatcher.forward(request, response);
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}