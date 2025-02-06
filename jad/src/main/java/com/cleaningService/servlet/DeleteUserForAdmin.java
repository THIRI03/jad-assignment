package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.cleaningService.dao.UserDAO;

/**
 * Servlet implementation class DeleteUserForAdmin
 */
@WebServlet("/DeleteUserForAdmin")
public class DeleteUserForAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUserForAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int user_id = Integer.parseInt(request.getParameter("userId"));

		UserDAO userDAO = new UserDAO();
		boolean isDeleted = false;
		
		isDeleted = userDAO.deleteUser(user_id);
		
		if(!isDeleted) {
			request.setAttribute("message", "User is not deleted.");
        	request.getRequestDispatcher("/jsp/adminUpdateUserInformation.jsp?userId=" + user_id).forward(request, response);
		}else {
			request.setAttribute("message", "User has been deleted successfully.");
        	request.getRequestDispatcher("/jsp/adminUpdateUserInformation.jsp?userId=" + user_id).forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
