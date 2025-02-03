package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.cleaningService.dao.BookingDAO;
import com.cleaningService.model.Booking;

/**
 * Servlet implementation class GroupBookingByStatusServlet
 */
@WebServlet("/FilterBookingByStatusServlet")
public class FilterBookingByStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FilterBookingByStatusServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String status = request.getParameter("status");
				
		
		BookingDAO bookingDAO = new BookingDAO();
		List<Booking>bookings = bookingDAO.retrieveAllBookingsByGrouping(status);
		
		request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/jsp/adminManageBooking.jsp").forward(request, response);
	}

}
