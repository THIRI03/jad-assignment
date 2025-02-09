/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/

package com.cleanerThirdParty.servlet;

import java.io.IOException;

import com.cleanerThirdParty.dao.CleanerDAO;
import com.cleanerThirdParty.model.Cleaner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginCleanerServlet
 */
@WebServlet("/LoginCleanerServlet")
public class LoginCleanerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCleanerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");

		CleanerDAO cleanerDAO = new CleanerDAO();
		Cleaner cleaner = new Cleaner();

		cleaner = cleanerDAO.getCleanerByEmail(email);

		int cleanerId = cleaner.getId();

		if(cleaner != null) {
	        request.setAttribute("cleanerId", cleanerId);
	        System.out.print(request.getAttribute("cleanerId") + "at login.jsp");
	        request.getRequestDispatcher("/GetBookingForThirdParty").forward(request, response);
		}else {
			request.setAttribute("error", "Not found");
		}

	}

}
