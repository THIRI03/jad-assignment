<!-- JAD-CA1
Class-DIT/FT/2A/23
Student Name: Thiri Lae Win,Moe Myat Thwe
Admin No.: P2340739,P2340362 -->

<%@ page import="com.cleaningService.dao.UserDAO"%>
<%@ page import="com.cleaningService.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register | Shiny</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/auth.css?v=1">
</head>

<body>

	<main class="auth-page">

		<div class="auth-card register-layout">

			<section class="auth-form-section register-form-section">

				<a class="auth-logo" href="home.jsp"> <img
					src="<%=request.getContextPath()%>/gallery/ShinyLogo.jpg"
					alt="Shiny Logo"> <span>Shiny</span>
				</a>

				<div class="auth-heading">
					<h1>Create an Account</h1>
					<p>Register to book and manage cleaning services.</p>
				</div>

				<form method="post" class="auth-form">

					<div class="form-grid">

						<div class="form-group">
							<label for="name">Name</label> <input type="text" id="name"
								name="name" placeholder="Enter your name" required>
						</div>

						<div class="form-group">
							<label for="email">Email</label> <input type="email" id="email"
								name="email" placeholder="Enter your email" required>
						</div>

						<div class="form-group">
							<label for="password">Password</label>

							<div class="password-container">
								<input type="password" id="password" name="password"
									placeholder="Create a password" required> <img
									src="<%=request.getContextPath()%>/gallery/eye-close-password.png"
									id="eye-password" alt="Show password">
							</div>
						</div>

						<div class="form-group">
							<label for="repassword">Confirm Password</label>

							<div class="password-container">
								<input type="password" id="repassword" name="repassword"
									placeholder="Confirm your password" required> <img
									src="<%=request.getContextPath()%>/gallery/eye-close-password.png"
									id="eye-repassword" alt="Show confirmed password">
							</div>
						</div>

						<div class="form-group">
							<label for="phoneNum">Phone Number</label> <input type="tel"
								id="phoneNum" name="phoneNum"
								placeholder="Enter your phone number" required>
						</div>

						<div class="form-group">
							<label for="postalcode">Postal Code</label> <input type="text"
								id="postalcode" name="postalcode" inputmode="numeric"
								placeholder="Enter postal code" required>
						</div>

						<div class="form-group full-width">
							<label for="address">Address</label> <input type="text"
								id="address" name="address" placeholder="Enter your address"
								required>
						</div>

					</div>

					<button type="submit" class="auth-button">Register</button>

				</form>

				<p class="auth-switch">
					Already have an account? <a href="login.jsp">Login</a>
				</p>

			</section>

			<section class="auth-image-section">

				<div class="image-content">
					<img
						src="<%=request.getContextPath()%>/gallery/Cleaning_Staff_illustration.png"
						alt="Cleaning staff illustration">

					<h2>Join Shiny today</h2>

					<p>Whether it's your home, office, or workplace, our friendly
						and professional team is ready to deliver reliable, high-quality
						cleaning services. Book your service in just a few clicks and
						enjoy a spotless, fresh, and welcoming space with peace of mind.</p>
				</div>

			</section>

		</div>

	</main>

	<%
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String repassword = request.getParameter("repassword");
		String phoneNumStr = request.getParameter("phoneNum");
		String address = request.getParameter("address");
		int postalCode = Integer.parseInt(request.getParameter("postalcode"));

		int role = 2;

		if (!password.equals(repassword)) {
	%>

	<script>
		alert("Password and confirmed password do not match.");
	</script>

	<%
	} else {
	User user = new User(name, email, password, phoneNumStr, address, postalCode, role);

	UserDAO userDAO = new UserDAO();
	boolean success = userDAO.registerUser(user);

	if (success) {
		response.sendRedirect("login.jsp");
		return;
	} else {
	%>

	<script>
		alert("Registration failed. Please try again.");
	</script>

	<%
	}
	}
	}
	%>

	<script>
		function setupPasswordToggle(inputId, iconId) {
			const input = document.getElementById(inputId);
			const icon = document.getElementById(iconId);

			icon.addEventListener("click", function () {
				if (input.type === "password") {
					input.type = "text";
					icon.src =
						"<%=request.getContextPath()%>/gallery/eye-open-password.png";
				} else {
					input.type = "password";
					icon.src =
						"<%=request.getContextPath()%>
		/gallery/eye-close-password.png";
								}
							});
		}

		setupPasswordToggle("password", "eye-password");
		setupPasswordToggle("repassword", "eye-repassword");
	</script>

</body>
</html>