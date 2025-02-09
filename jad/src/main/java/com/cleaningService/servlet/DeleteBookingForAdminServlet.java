/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;

import com.cleaningService.dao.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteBookingForAdminServlet
 */
@WebServlet("/DeleteBookingForAdminServlet")
public class DeleteBookingForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteBookingForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = Integer.parseInt(request.getParameter("bookingId"));
		BookingDAO bookingDAO = new BookingDAO();
		boolean isDeleted = false;

		isDeleted = bookingDAO.deleteBookingById(id);
		if(!isDeleted) {
			request.setAttribute("message", "Booking is not deleted.");
        	request.getRequestDispatcher("/GetBookingDetailsForAdminServlet?booking_id="+ id).forward(request, response);
		}else {
			request.setAttribute("message", "Booking has been deleted successfully.");
        	request.getRequestDispatcher("/SortAndFilterBookingByDateAndIdServlet").forward(request, response);
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
