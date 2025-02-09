/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
 * Servlet implementation class GetBookingById
 */
@WebServlet("/GetBookingById")
public class GetBookingById extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBookingById() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int cleanerId = Integer.parseInt(request.getParameter("cleanerId"));
    System.out.println(cleanerId + " cleanerId");

    PrintWriter out = response.getWriter();
    Client client = ClientBuilder.newClient();

    String restUrl = "http://localhost:8081/user-ws/getBooking/{cleanerId}";
    WebTarget target = client.target(restUrl).resolveTemplate("cleanerId", cleanerId);
    Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
    Response resp = invocationBuilder.get();

    System.out.println("status: " + resp.getStatus());

    if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
        System.out.println("success");
        List<Booking> bookings = resp.readEntity(new GenericType<List<Booking>>() {});
        request.setAttribute("bookingsByCleanerId", bookings);

        System.out.println("...requestObj set...forwarding...");
        String url = "/third-party-cleaner-service/getBookingForEachCleaner.jsp?cleanerId=" + cleanerId;
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    } else {
        System.out.println("failed");
        String url = "/third-party-cleaner-service/getBookingForEachCleaner.jsp?cleanerId=" + cleanerId;
        request.setAttribute("err", "NotFound");
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
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
