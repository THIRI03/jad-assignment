<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // Invalidating the session to log the user out
    if (session != null) {
        session.invalidate(); // Invalidate the session to log out the user
    }

    // Redirect to the login page or home page after logging out
    response.sendRedirect("login.jsp");  
    
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                cookie.setMaxAge(0); // Expire the cookie
                response.addCookie(cookie);
            }
        }
    }

    // Redirect to home page
    response.sendRedirect("home.jsp");
%>
</body>
</html> --%>

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
