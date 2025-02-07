package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.cleaningService.dao.BookingDAO;

/**
 * Servlet implementation class UpdateBookingStatusForAdminServlet
 */
@WebServlet("/UpdateBookingStatusForAdminServlet")
public class UpdateBookingStatusForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateBookingStatusForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int booking_id = Integer.parseInt(request.getParameter("booking_id"));
		String status = request.getParameter("statusChange");
		
		BookingDAO bookingDAO = new BookingDAO();
		boolean isUpdated = false;
		
		isUpdated = bookingDAO.updateBookingStatus(booking_id, status);
		
		if(isUpdated) {
			request.setAttribute("message", "Status has been updated.");
        	request.getRequestDispatcher("/SortAndFilterBookingByDateAndIdServlet").forward(request, response);
		}else {
			request.setAttribute("message", "There's an error updating status.");
        	request.getRequestDispatcher("/jsp/adminManageBooking.jsp").forward(request, response);
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
