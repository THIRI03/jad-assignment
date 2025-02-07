package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.cleaningService.dao.BookingDAO;
import com.cleaningService.model.Booking;

/**
 * Servlet implementation class GetBookingDetailsForAdminServlet
 */
@WebServlet("/GetBookingDetailsForAdminServlet")
public class GetBookingDetailsForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetBookingDetailsForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int booking_id = Integer.parseInt(request.getParameter("booking_id"));
		
		BookingDAO bookingDAO = new BookingDAO();
		Booking booking = new Booking();
		
		booking = bookingDAO.retrieveBookingById(booking_id);
		
		request.setAttribute("booking", booking);
        request.getRequestDispatcher("/jsp/adminManageBookingDetails.jsp").forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
