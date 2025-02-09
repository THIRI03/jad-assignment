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
 * Servlet implementation class UpdateBookingDateAndTimeForAdminServlet
 */
@WebServlet("/UpdateBookingDateAndTimeForAdminServlet")
public class UpdateBookingDateAndTimeForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateBookingDateAndTimeForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String date = request.getParameter("bookingDate");
		String time = request.getParameter("bookingTime");
		int id = Integer.parseInt(request.getParameter("bookingId"));

		boolean isUpdated = false;
		BookingDAO bookingDAO = new BookingDAO();
		isUpdated = bookingDAO.updateBookingDateAndTime(date, time, id);

		if (isUpdated) {
        	request.setAttribute("message", "Information updated successfully");
        	request.getRequestDispatcher("/GetBookingDetailsForAdminServlet?booking_id="+ id).forward(request, response);
        } else {
            request.setAttribute("message", "Failed to update user information.");
            request.getRequestDispatcher("/GetBookingDetailsForAdminServlet?booking_id="+ id).forward(request, response);
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
