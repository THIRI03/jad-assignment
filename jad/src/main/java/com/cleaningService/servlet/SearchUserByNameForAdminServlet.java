/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.dao.UserDAO;
import com.cleaningService.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class searchUserByNameForAdminServlet
 */
@WebServlet("/SearchUserByNameForAdminServlet")
public class SearchUserByNameForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchUserByNameForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String searchName = request.getParameter("searchName");

		List<User>users = new ArrayList<>();
		UserDAO userDAO = new UserDAO();
		users = userDAO.retrieveUserByName(searchName);

		if(users == null) {
			request.setAttribute("message", "No user found!");
        	request.getRequestDispatcher("/jsp/adminRetrieveMember.jsp").forward(request, response);
		}else {
			request.setAttribute("users", users);
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
