/*-----------
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
------------*/
package com.cleaningService.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AuthUtil {

    /**
     * Checks if the user is authenticated by validating the session token.
     * Redirects to the login page if the user is not authenticated.
     * 
     * @param request  the HTTP servlet request
     * @param response the HTTP servlet response
     * @return true if the user is authenticated, false otherwise
     */
    public static boolean checkAuthentication(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);  // Don't create a new session
        if (session == null) {
            redirectToLogin(response, request.getContextPath());
            return false;
        }

        String authToken = (String) session.getAttribute("authToken");
        if (authToken == null || !TokenUtil.isTokenValid(authToken)) {
            redirectToLogin(response, request.getContextPath());
            return false;
        }

        return true;
    }

    /**
     * Redirects the user to the login page.
     * 
     * @param response    the HTTP servlet response
     * @param contextPath the context path of the application
     */
    private static void redirectToLogin(HttpServletResponse response, String contextPath) throws IOException {
        response.sendRedirect(contextPath + "/jsp/login.jsp");
    }
}
