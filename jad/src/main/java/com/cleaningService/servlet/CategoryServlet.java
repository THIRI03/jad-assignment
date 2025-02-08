/*-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--*/
package com.cleaningService.servlet;

import com.cleaningService.dao.CategoryDAO;
import com.cleaningService.model.Category;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class CategoryServlet
 */
@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryDAO categoryDAO;

    public void init() {
        categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Step 2: Handle fetch parameter
    	String fetchParam = request.getParameter("fetch");

        // If fetch parameter is not set, display a default error or redirect
        if (fetchParam == null || !fetchParam.equals("true")) {
            response.sendRedirect(request.getContextPath() + "/error.jsp");
            return;
        }

     // Step 3: Retrieve categories
        List<Category> categories = categoryDAO.getAllCategory();

        if (categories == null || categories.isEmpty()) {
            System.out.println("DEBUG: No categories found!");
        } else {
            System.out.println("DEBUG: Categories retrieved: " + categories.size());
        }

        // Store categories in request scope
        request.setAttribute("categories", categories);

     // Step 4: Store categories in request scope and forward to categories.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/categories.jsp");
        dispatcher.forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}