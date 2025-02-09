/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.dao.FeedbackDAO;
import com.cleaningService.model.Feedback;

/**
 * Servlet implementation class AdminRetrieveAllFeedbackServlet
 */
@WebServlet("/AdminSortFeedbackServlet")
public class AdminSortFeedbackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminSortFeedbackServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String ratingStr = request.getParameter("rating");
		FeedbackDAO feedbackDAO = new FeedbackDAO();
		List<Feedback>feedbacks = new ArrayList<>();
		
		if("All Ratings".equals(ratingStr)) {
			feedbacks = feedbackDAO.retrieveAllFeedbacks();
		}else {
			int rating = Integer.parseInt(ratingStr);
			feedbacks = feedbackDAO.retrieveAllFeedbacksByRating(rating);
		}
		
		if(feedbacks == null) {
			request.setAttribute("message", "There's no feedback.");
	        request.getRequestDispatcher("/jsp/adminRetrieveAllFeedback.jsp").forward(request, response);
		}
		
		request.setAttribute("feedbackList", feedbacks);
		request.setAttribute("message", "Feedbacks found");
        request.getRequestDispatcher("/jsp/adminRetrieveAllFeedback.jsp").forward(request, response);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
