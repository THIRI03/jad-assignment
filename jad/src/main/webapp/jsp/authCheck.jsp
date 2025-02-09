<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "com.cleaningService.util.TokenUtil" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // Retrieve the token from the session
    String authToken = (String) session.getAttribute("authToken");

    // Check if the token is valid
    if (authToken == null || !TokenUtil.isTokenValid(authToken)) {
        // Redirect to the login page if the token is invalid
        response.sendRedirect("login.jsp");
        return;
    }
%>
</body>
</html>