/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import com.cleanerThirdParty.model.Booking;

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
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

/**
 * Servlet implementation class GetBookingForThirdParty
 */
@WebServlet("/GetBookingForThirdParty")
public class GetBookingForThirdParty extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GetBookingForThirdParty() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	/*
	 * @Override protected void doGet(HttpServletRequest request,
	 * HttpServletResponse response) throws ServletException, IOException { // TODO
	 * Auto-generated method stub PrintWriter out = response.getWriter(); Client
	 * client = ClientBuilder.newClient(); String restUrl =
	 * "http://localhost:8081/user-ws/getBooking"; WebTarget target =
	 * client.target(restUrl); Invocation.Builder invocationBuilder =
	 * target.request(MediaType.APPLICATION_JSON); Response resp =
	 * invocationBuilder.get(); System.out.println("status: " + resp.getStatus());
	 * 
	 * 
	 * 
	 * if(resp.getStatus() == Response.Status.OK.getStatusCode()) {
	 * System.out.println("success");
	 * 
	 * ArrayList<Booking> al = resp.readEntity(new GenericType<ArrayList<Booking>>()
	 * {});
	 * 
	 * 
	 * for(Booking booking : al) { System.out.println(booking.getDuration());
	 * System.out.println(booking.getSpecialRequest());
	 * System.out.println(booking.getDuration()); }
	 * 
	 * int cleanerId = Integer.parseInt(request.getParameter("cleanerId"));
	 * 
	 * System.out.print(cleanerId);
	 * 
	 * request.setAttribute("bookingArray", al); request.setAttribute("cleanerId",
	 * cleanerId); System.out.print("...requestObj set...forwarding..."); String url
	 * = "/third-party-cleaner-service/getBookingForthird-party.jsp";
	 * RequestDispatcher rd = request.getRequestDispatcher(url); rd.forward(request,
	 * response);
	 * 
	 * }else { System.out.println("failed"); String url =
	 * "/third-party-cleaner-service/getBookingForthird-party.jsp";
	 * request.setAttribute("err", "NotFound"); RequestDispatcher rd =
	 * request.getRequestDispatcher(url); rd.forward(request, response);
	 * 
	 * }
	 * }
	 */

	

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Handle POST request
		PrintWriter out = response.getWriter();
		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8081/user-ws/getBooking";
		WebTarget target = client.target(restUrl);
		Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
		Response resp = invocationBuilder.get();

		if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
			ArrayList<Booking> al = resp.readEntity(new GenericType<ArrayList<Booking>>() {
			});
			String cleanerIdStr = request.getParameter("cleanerId");
			int cleanerId = 0;
			if(cleanerIdStr == null) {
				cleanerId = (int) request.getAttribute("cleanerId");
			}else {
				cleanerId = Integer.parseInt(cleanerIdStr);
			}
			request.setAttribute("bookingArray", al);
			request.setAttribute("cleanerId", cleanerId);
			String url = "/third-party-cleaner-service/getBookingForthird-party.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
		} else {
			request.setAttribute("err", "NotFound");
			String url = "/third-party-cleaner-service/getBookingForthird-party.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(url);
			rd.forward(request, response);
		}
	}

}
