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
 * Servlet implementation class FilterServicesForAdminServlet
 */
@WebServlet("/FilterServicesForAdminServlet")
public class FilterServicesForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public FilterServicesForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String filter = request.getParameter("filter");
		ServiceDAO serviceDAO = new ServiceDAO();
		List<Service>services = new ArrayList<>();

		if ("top3Rated".equals(filter) || "least3Rated".equals(filter)) {
            services = serviceDAO.retrieveTopAndLeastRatedServices(filter);
        } else if ("top3InDemand".equals(filter) || "least3InDemand".equals(filter)) {
            services = serviceDAO.retrieveServicesInDemand(filter);
        } else if ("All".equals(filter)) {
            services = serviceDAO.retrieveService();
        }

		request.setAttribute("filteredServices", services);
        request.getRequestDispatcher("/jsp/adminRetrieveServices.jsp").forward(request, response);
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
