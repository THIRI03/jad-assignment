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
<title>Insert title here</title>
<style type="text/css">
/* Apply basic styles for body */
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

/* Login card container */
.login-card {
    background-color: #ffffff;
    box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
    padding: 40px 30px;
    width: 360px;
    border-radius: 12px;
    text-align: center;
}

/* Heading style */
.login-card h2 {
    color: #343a40;
    margin-bottom: 20px;
}

/* Label style */
.login-card label {
    display: block;
    text-align: left;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 5px;
    color: #495057;
}

/* Input field style */
.login-card input[type="email"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ced4da;
    border-radius: 6px;
    box-sizing: border-box;
}

/* Button style */
.login-card button {
    background-color: #343a40;
    color: #ffffff;
    border: none;
    padding: 10px 15px;
    border-radius: 8px;
    cursor: pointer;
    width: 100%;
    font-size: 14px;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.login-card button:hover {
    background-color: #495057;
}

/* Registration link */
.login-card h5 {
    margin-top: 15px;
    font-size: 14px;
    color: #6c757d;
}

.login-card a {
    text-decoration: none;
    font-weight: bold;
}

.login-card a:hover {
    text-decoration: underline;
}

</style>
</head>
<body>
<div class="login-card">
        <h2>Login</h2>
        <form action = "<%=request.getContextPath()%>/LoginCleanerServlet" method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <button type="submit">Login</button>
        </form>
        <br>
        <h5>Don't have an account? <a href="register.jsp" style="color: #343a40;">Register</a></h5>
    </div>
</body>
</html>