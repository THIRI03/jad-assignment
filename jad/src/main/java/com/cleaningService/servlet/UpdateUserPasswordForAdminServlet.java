/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import com.cleaningService.dao.UserDAO;
import com.cleaningService.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateUserPasswordForAdmin
 */
@WebServlet("/UpdateUserPasswordForAdminServlet")
public class UpdateUserPasswordForAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateUserPasswordForAdminServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected boolean isSamePassword(String newPassword, String confirmPassword) {
    	boolean isSamePassword = false;

    	// check if the passwords are the same
    	if(newPassword.equals(confirmPassword)) {
    		isSamePassword = true;
    	}
		return isSamePassword;

    }


    protected boolean isCurrentPasswordTrue(String currentPassword, String currentStoredPassword) {
    	boolean isCurrentPasswordTrue = false;

    	if(BCrypt.checkpw(currentPassword, currentStoredPassword)) {
    		isCurrentPasswordTrue = true;
    	}

    	return isCurrentPasswordTrue;
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int user_id = Integer.parseInt(request.getParameter("userId"));

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if(!isSamePassword(newPassword, confirmPassword)) {
        	request.setAttribute("message", "Passwords are not the same");
        	request.getRequestDispatcher("/jsp/adminUpdateUserInformation.jsp?userId=" + user_id).forward(request, response);
        }



        UserDAO userDAO = new UserDAO();
        User user = new User();
        user = userDAO.retrieveUserPwdById(user_id);
        String currentStoredPassword = user.getPassword();

        if(!isCurrentPasswordTrue(currentPassword, currentStoredPassword)){
        	request.setAttribute("message", "Current Password entered is incorrect.");
        	request.getRequestDispatcher("/jsp/adminUpdateUserInformation.jsp?userId=" + user_id).forward(request, response);
        }

        boolean updateSuccess = userDAO.updateUserPassword(newPassword, user_id);

        if (updateSuccess) {
        	request.setAttribute("message", "Information updated successfully");
        	request.getRequestDispatcher("/jsp/adminUpdateUserInformation.jsp?userId=" + user_id).forward(request, response);
        } else {
            request.setAttribute("message", "Failed to update password.");
            request.getRequestDispatcher("/jsp/adminUpdateUserInformation.jsp?userId=" + user_id).forward(request, response);
        }
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}



}
