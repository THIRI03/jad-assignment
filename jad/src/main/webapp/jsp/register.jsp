<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ page import="com.cleaningService.model.User" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="authCheck.jsp" %>


<html>
<head>
    <link rel="stylesheet" type="text/css" href="../css/register.css">
    <title>Register</title>
    
</head>
<body>
<div class="register-card">
        <h2>Register</h2>
        <form method="post">
        
            <label for="name">Name:</label>
	        <input type="text" id="name" name="name" required><br><br>
	
	        <label for="email">Email:</label>
	        <input type="email" id="email" name="email" required><br><br>
	
	        <label for="password">Password</label>
            <div class="password-container">
                <input type="password" id="password" name="password" required>
                <img src="../gallery/eye-close-password.png" id="eye-close-password">
            </div><br>

            <label for="repassword">Confirm Password</label>
            <div class="password-container">
                <input type="password" id="repassword" name="repassword" required>
                <img src="../gallery/eye-close-password.png" id="eye-close-repassword">
            </div><br>
	
			<label for="phoneNum">Phone Number: </label>
	        <input type="tel" id="phoneNum" name="phoneNum" required><br><br>
	        
	        <label for="address">Address:</label>
	        <input type="text" id="address" name="address" required><br><br>
	        
	        <label for="postalcode">Postal Code:</label>
	        <input type="number" id="postalcode" name="postalcode" required><br><br>

            <button type="submit">Register</button>
        </form>
        <br>
        <h5>Already have an account? <a href="login.jsp" style="color: #343a40;">Login</a></h5>
    </div>

    <%
    
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String repassword = request.getParameter("repassword");
            String phoneNumStr = request.getParameter("phoneNum");
            int phoneNum = Integer.parseInt(phoneNumStr);
            String address = request.getParameter("address");
            int postalCode = Integer.parseInt(request.getParameter("postalcode"));
            int role = 2;
            
            if(!password.equals(repassword)){
            	%>
            	<script>alert('Password and repassword are not the same')</script>
            	<%        

            }else{
            	// Create a User object
                User user = new User(name, email, password, phoneNum, address, postalCode, role);

                // Call the UserDAO to register the user
                UserDAO userDAO = new UserDAO();
                boolean success = userDAO.registerUser(user);

                if (success) {
                	session.setAttribute("username", name);
                	%>
                	<script>alert('Registered successful!')</script>
                	<%
                	response.sendRedirect("login.jsp");
                } else {
                	%>
                	<script>alert('Registered failed!')</script>
                	<%
                }
            }
        }
    %>
    
    <script>
    function togglePasswordVisibility(inputField, icon) {
        if (inputField.type === "password") {
            inputField.type = "text";
            icon.src = "../gallery/eye-open-password.png";
        } else {
            inputField.type = "password";
            icon.src = "../gallery/eye-close-password.png";
        }
    }
    function setupPasswordToggle() {
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
    window.addEventListener("DOMContentLoaded", setupPasswordToggle);

    </script>
</body>
</html>
