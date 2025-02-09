package com.cleaningService.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.io.IOException;

import com.cleaningService.model.Service;
/**
 * Servlet implementation class ThirdParty_GetServiceByIdServlet
 */
@WebServlet("/ThirdParty_GetServiceByIdServlet")
public class ThirdParty_GetServiceByIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThirdParty_GetServiceByIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
    	// Retrieve service ID from the request
        String serviceId = request.getParameter("serviceId");

        // Build REST client and make the request
        Client client = ClientBuilder.newClient();
        String restUrl = "http://localhost:8081/user-ws/service/getService/" + serviceId;  // REST endpoint
        WebTarget target = client.target(restUrl);
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response resp = invocationBuilder.get();

        System.out.println("Status: " + resp.getStatus());

        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
            // Request succeeded, read and forward the service details
            System.out.println("Service found successfully.");
            Service service = resp.readEntity(Service.class);

            request.setAttribute("service", service);
            String url = "third-party-cleaner-service/serviceDetails.jsp";  // Update with your JSP file name
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        } else {
            // Handle case where service is not found
            System.out.println("Service not found.");
            request.setAttribute("err", "ServiceNotFound");
            String url = "third-party-cleaner-service/serviceDetails.jsp";  // Update with your JSP file name
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
