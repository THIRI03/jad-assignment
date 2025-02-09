/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.cleaningService.dao.FeedbackDAO;
import com.cleaningService.model.Feedback;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetAllFeedbacksForAdminServlet
 */
@WebServlet("/GetAllFeedbacksForAdminServlet")
public class GetAllFeedbacksForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAllFeedbacksForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		FeedbackDAO feedbackDAO = new FeedbackDAO();
		List<Feedback>feedbacks = new ArrayList<>();

		feedbacks = feedbackDAO.retrieveAllFeedbacks();
		
		if(feedbacks == null) {
			request.setAttribute("message", "There's no feedback.");
	        request.getRequestDispatcher("/jsp/adminRetrieveAllFeedback.jsp").forward(request, response);
		}
		
		request.setAttribute("feedbackList", feedbacks);
		request.setAttribute("message", "Feedbacks found");
        request.getRequestDispatcher("/jsp/adminRetrieveAllFeedback.jsp").forward(request, response);
		
		
	}


}
