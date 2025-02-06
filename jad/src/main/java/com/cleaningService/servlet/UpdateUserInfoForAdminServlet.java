package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.cleaningService.dao.UserDAO;

/**
 * Servlet implementation class UpdateCustomerInfoForAdmin
 */
@WebServlet("/UpdateUserInfoForAdminServlet")
public class UpdateUserInfoForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserInfoForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int user_id = Integer.parseInt(request.getParameter("user_id"));
		
        String name = request.getParameter("username");
        String email = request.getParameter("email");
        int phone = Integer.parseInt(request.getParameter("phone"));
    
        UserDAO userDAO = new UserDAO();
        boolean updateSuccess = userDAO.updateUserInformation(name, email, phone, user_id);

        if (updateSuccess) {
        	request.setAttribute("message", "Information updated successfully");
        	request.getRequestDispatcher("/jsp/adminUpdateUserInformation.jsp?userId=" + user_id).forward(request, response);
        } else {
            request.setAttribute("error", "Failed to update user information.");
            request.getRequestDispatcher("/jsp/adminUpdateUserInformation.jsp").forward(request, response);
        }
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}


}
