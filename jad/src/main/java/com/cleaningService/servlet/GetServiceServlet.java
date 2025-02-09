/*-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--*/
package com.cleaningService.servlet;

import com.cleaningService.dao.ServiceDAO;
import com.cleaningService.model.Service;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class ServiceServlet
 */
@WebServlet("/GetServiceServlet")
public class GetServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ServiceDAO serviceDAO;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetServiceServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init() {
        serviceDAO = new ServiceDAO();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		int categoryId = Integer.parseInt(request.getParameter("category_id"));

        // Retrieve services by category ID
        List<Service> services = serviceDAO.retrieveServicesByCategoryId(categoryId);

        // Store services in the request attribute
        request.setAttribute("services", services);

        // Forward to the services.jsp page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/services.jsp");
        dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
