/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;

import com.cleaningService.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int user_id = Integer.parseInt(request.getParameter("userId"));

		UserDAO userDAO = new UserDAO();
		boolean isDeleted = false;

		isDeleted = userDAO.deleteUser(user_id);

		if(!isDeleted) {
			request.setAttribute("message", "User is not deleted.");
        	request.getRequestDispatcher("/jsp/adminRetrieveMember.jsp").forward(request, response);
		}else {
			request.setAttribute("message", "User has been deleted successfully.");
        	request.getRequestDispatcher("/jsp/adminRetrieveMember.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
