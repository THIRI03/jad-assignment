/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;
import java.util.List;

import com.cleaningService.dao.BookingDAO;
import com.cleaningService.model.Booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SortAndFilterBookingByDateAndIdServlet
 */
@WebServlet("/SortAndFilterBookingByDateAndIdServlet")
public class SortAndFilterBookingByDateAndIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SortAndFilterBookingByDateAndIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String sortBooking = request.getParameter("sortBooking");
        String status = request.getParameter("status");

        // Default sorting by "id" and status "All"
        if (sortBooking == null) {
            sortBooking = "id";
        }

        if (status == null) {
            status = "All";
        }

        BookingDAO bookingDAO = new BookingDAO();
        List<Booking> bookings = bookingDAO.retrieveAllBookingsBySortedAndStatus(sortBooking, status);

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/jsp/adminManageBooking.jsp").forward(request, response);
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
