<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logout</title>
</head>
<body>
<%
    // Check if the session exists, then invalidate it to log out the user
    if (session != null) {
        session.invalidate();
    }

    // Remove the "userId" cookie if it exists
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("userId".equals(cookie.getName())) {
                cookie.setMaxAge(0); // Expire the cookie immediately
                response.addCookie(cookie);
            }
        }
    }

    // Redirect to the login page after logging out
    response.sendRedirect("login.jsp");  
%>
</body>
</html>
