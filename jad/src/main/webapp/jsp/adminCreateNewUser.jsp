<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="authCheck.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create New User</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/adminCreateNewUser.css">
</head>
<body>
<h1>Create New User</h1>

    <!-- User Registration Form -->
    <form action="<%=request.getContextPath()%>/CreateNewUserForAdminServlet" method="POST">
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br><br>

        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password" required><br><br>
        
        <label for="confirmPassword">Confirm Password:</label><br>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>

        <label for="phoneNum">Phone Number:</label><br>
        <input type="text" id="phoneNum" name="phoneNum" required><br><br>

        <label for="address">Address:</label><br>
        <input type="text" id="address" name="address" required><br><br>

        <label for="postalCode">Postal Code:</label><br>
        <input type="text" id="postalCode" name="postalCode" required><br><br>

        <button type="submit">Register</button>
        
        <a href="adminRetrieveMember.jsp" style="text-decoration: none">
        Back to User Lists</a>
        
    </form>
</body>
</html>