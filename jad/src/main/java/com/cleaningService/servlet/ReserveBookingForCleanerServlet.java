/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import com.cleanerThirdParty.model.Cleaner;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

/**
 * Servlet implementation class ReserveBookingForCleanerServlet
 */
@WebServlet("/ReserveBookingForCleanerServlet")
public class ReserveBookingForCleanerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReserveBookingForCleanerServlet() {
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
		int cleanerId = Integer.parseInt(request.getParameter("cleanerId"));
		System.out.print(cleanerId + "cleanerId");

		int bookingId = Integer.parseInt(request.getParameter("bookingId"));

		Cleaner cleaner = new Cleaner();
		cleaner.setId(cleanerId);

		PrintWriter out = response.getWriter();
		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8081/user-ws/reserveBooking/{bookingId}";
	    WebTarget target = client.target(restUrl).resolveTemplate("bookingId", bookingId);
		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invocationBuilder.put(Entity.json(cleaner));
		System.out.println("status: " + resp.getStatus());

		if(resp.getStatus() == Response.Status.OK.getStatusCode()) {

			String url = "GetBookingById?cleanerId=" + cleanerId;
			RequestDispatcher rd = request.getRequestDispatcher(url);
        	rd.forward(request, response);

		}else {
			System.out.println("failed");
			String url = "/GetBookingForThirdParty";
			request.setAttribute("err", "NotFound");
			RequestDispatcher rd = request.getRequestDispatcher(url);
        	rd.forward(request, response);

		}
	}

}
