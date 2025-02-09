/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.dao.ServiceDAO;
import com.cleaningService.model.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SearchServiceNameForAdminServlet
 */
@WebServlet("/SearchServiceNameForAdminServlet")
public class SearchServiceNameForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServiceNameForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userInput = request.getParameter("userInput");

		List<Service> services = new ArrayList<>();
		ServiceDAO serviceDAO = new ServiceDAO();

		services = serviceDAO.retrieveServiceByName(userInput);

		if(services == null) {
			request.setAttribute("message", "No service found.");
        	request.getRequestDispatcher("/jsp/adminRetrieveServices.jsp").forward(request, response);
		}else {
        	System.out.print("servlet found");
			request.setAttribute("servicesAfterSearch", services);
        	request.getRequestDispatcher("/jsp/adminRetrieveServices.jsp").forward(request, response);
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
