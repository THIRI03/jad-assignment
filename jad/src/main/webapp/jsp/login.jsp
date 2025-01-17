<!-- JAD-CA1
Class-DIT/FT/2A/23
Student Name: Thiri Lae Win
Admin No.: P2340739 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.cleaningService.model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.util.Date, java.util.Calendar, java.util.Base64" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="../css/login.css">


</head>
<body>
    <div class="login-card">
        <h2>Login</h2>
        <form method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password</label>
            <div class="password-container">
                <input type="password" id="password" name="password" required>
                <img src="../gallery/eye-close-password.png" id="eye-close-password">
            </div>
            <button type="submit">Login</button>
        </form>
        <br>
        <h5>Don't have an account? <a href="register.jsp" style="color: #343a40;">Register</a></h5>
    </div>
    
    <%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEmail(email, password);


        if (user != null) {
        	        	
        	int roleId = user.getRoleId();
        	session.setAttribute("userRole", roleId);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getName());
            Integer userId = (Integer)session.getAttribute("userId");
            
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.MINUTE, 30);
            String token = Base64.getEncoder().encodeToString((email + ":" + calendar.getTimeInMillis()).getBytes());
            
            session.setAttribute("authToken", token);
            
            /* JAD-CA1
            Class-DIT/FT/2A/23
            Student Name: Moe Myat Thwe
            Admin No.: P2340362 */
         	// Save user ID in a cookie
            Cookie userCookie = new Cookie("userId", String.valueOf(user.getId()));
            userCookie.setMaxAge(60 * 60 * 24); // 1-day expiry
            response.addCookie(userCookie);
            
            /* JAD-CA1
            Class-DIT/FT/2A/23
            Student Name: Thiri Lae Win
            Admin No.: P2340739 */
            %>
        	<script>alert('Login Successful!')</script>
        	<%
            if(roleId == 1){
            	response.sendRedirect("adminDashboard.jsp");
            }else if(roleId == 2 || roleId == 3){
            	response.sendRedirect(request.getContextPath()+"/jsp/home.jsp");
            }
        } else {
        	%>
        	<script>alert('Login Failed!')</script>
        	<%        
       	}
    }
    %>
    
    <!-- For show password -->
    <script>
    /* function togglePasswordVisibility(inputField, icon) {
        if (inputField.type === "password") {
            inputField.type = "text";
            icon.src = "../gallery/eye-open-password.png";
        } else {
            inputField.type = "password";
            icon.src = "../gallery/eye-close-password.png";
        }
    } */
    /* function setupPasswordToggle() {
        const eyePassword = document.getElementById("eye-close-password");
        const eyeRepassword = document.getElementById("eye-close-repassword");
        const password = document.getElementById("password");
        const repassword = document.getElementById("repassword");

        eyePassword.onclick = function () {
            togglePasswordVisibility(password, eyePassword);
        };

        eyeRepassword.onclick = function () {
            togglePasswordVisibility(repassword, eyeRepassword);
        };
    }
    window.addEvent Listener("DOMContentLoaded", setupPasswordToggle);*/

    </script>
</body>

</html>