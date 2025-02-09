/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;

import com.cleaningService.dao.UserDAO;
import com.cleaningService.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateNewUserForAdminServlet
 */
@WebServlet("/CreateNewUserForAdminServlet")
public class CreateNewUserForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateNewUserForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        int phoneNum = Integer.parseInt(request.getParameter("phoneNum"));
        String address = request.getParameter("address");
        int postalCode = Integer.parseInt(request.getParameter("postalCode"));
        int role = 2;

        if(!password.equals(confirmPassword)) {
        	request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/jsp/adminRetrieveMember.jsp").forward(request, response);
        }
        // Create User object
        User user = new User(name, email, password, phoneNum, address, postalCode, role);

        // Register the user using UserDAO
        UserDAO userDAO = new UserDAO();
        boolean isCreated = userDAO.registerUser(user);

        if (isCreated) {
            request.setAttribute("message", "User created successfully");
        } else {
            request.setAttribute("message", "Failed to create service.");
        }

        request.getRequestDispatcher("/jsp/adminRetrieveMember.jsp").forward(request, response);
	}

}
