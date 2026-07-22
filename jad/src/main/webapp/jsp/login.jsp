<!-- JAD-CA1
Class-DIT/FT/2A/23
Student Name: Thiri Lae Win,Moe Myat Thwe
Admin No.: P2340739,P2340362 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.cleaningService.dao.UserDAO"%>
<%@ page import="com.cleaningService.model.User"%>
<%@ page import="java.util.Calendar, java.util.Base64"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login | Shiny</title>

	<link rel="stylesheet"
		href="<%=request.getContextPath()%>/css/auth.css?v=1">
</head>

<body>

	<main class="auth-page">

		<div class="auth-card login-layout">

			<section class="auth-form-section">

				<a class="auth-logo" href="home.jsp">
					<img
						src="<%=request.getContextPath()%>/gallery/ShinyLogo.jpg"
						alt="Shiny Logo">
					<span>Shiny</span>
				</a>

				<div class="auth-heading">
					<h1>Welcome Back!</h1>
					<p>Sign in to continue booking your cleaning services.</p>
				</div>

				<form method="post" class="auth-form">

					<div class="form-group">
						<label for="email">Email</label>
						<input type="email" id="email" name="email"
							placeholder="Enter your email" required>
					</div>

					<div class="form-group">
						<label for="password">Password</label>

						<div class="password-container">
							<input type="password" id="password" name="password"
								placeholder="Enter your password" required>

							<img
								src="<%=request.getContextPath()%>/gallery/eye-close-password.png"
								id="eye-password"
								alt="Show password">
						</div>
					</div>

					<button type="submit" class="auth-button">
						Login
					</button>

				</form>

				<p class="auth-switch">
					Don't have an account?
					<a href="register.jsp">Register</a>
				</p>

			</section>

			<section class="auth-image-section">

				<div class="image-content">
					<img
						src="<%=request.getContextPath()%>/gallery/Cleaning_Staff_illustration.png"
						alt="Cleaning staff illustration">

					<h2>Every Space Deserves to Shine</h2>

					<p>
						Whether it's your home, office, or workplace, our friendly and professional team is ready to deliver reliable, high-quality cleaning services. Book your service in just a few clicks and enjoy a spotless, fresh, and welcoming space with peace of mind.
					</p>
				</div>

			</section>

		</div>

	</main>

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

			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.MINUTE, 30);

			String token = Base64.getEncoder().encodeToString(
				(email + ":" + calendar.getTimeInMillis()).getBytes()
			);

			session.setAttribute("authToken", token);

			Cookie userCookie =
				new Cookie("userId", String.valueOf(user.getId()));

			userCookie.setMaxAge(60 * 60 * 24);
			response.addCookie(userCookie);

			if (roleId == 1) {
				response.sendRedirect("adminDashboard.jsp");
				return;
			} else if (roleId == 2 || roleId == 3) {
				response.sendRedirect(
					request.getContextPath() + "/jsp/home.jsp"
				);
				return;
			}

		} else {
	%>

	<script>
		alert("Login failed. Please check your email and password.");
	</script>

	<%
		}
	}
	%>

	<script>
		const passwordInput = document.getElementById("password");
		const passwordIcon = document.getElementById("eye-password");

		passwordIcon.addEventListener("click", function () {
			if (passwordInput.type === "password") {
				passwordInput.type = "text";
				passwordIcon.src =
					"<%=request.getContextPath()%>/gallery/eye-open-password.png";
			} else {
				passwordInput.type = "password";
				passwordIcon.src =
					"<%=request.getContextPath()%>/gallery/eye-close-password.png";
			}
		});
	</script>

</body>
</html>