package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.cleaningService.dao.BookingDAO;
import com.cleaningService.model.Booking;

/**
 * Servlet implementation class sortBookingByDataAndIdServlet
 */
@WebServlet("/SortBookingByDateAndIdServlet")
public class SortBookingByDateAndIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SortBookingByDateAndIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String sortBooking = request.getParameter("sortBooking");

		if(sortBooking == null) {
			sortBooking = "id";
		}
		
		BookingDAO bookingDAO = new BookingDAO();
		List<Booking>bookings = bookingDAO.retrieveAllBookingsBySortedColumn(sortBooking);
		
		request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/jsp/adminManageBooking.jsp").forward(request, response);
	}



}
