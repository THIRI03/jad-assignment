
<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win,Moe Myat Thwe
    Admin No.: P2340739,P2340362
--%>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/adminNavbar.css?v=4">

<header>
	<nav>
		<div class="admin-navbar-container">

			<div class="admin-logo">
				<a href="adminDashboard.jsp">
					<img
						src="<%=request.getContextPath()%>/gallery/ShinyLogo.jpg"
						alt="Shiny Logo">
					<span>Shiny</span>
				</a>
			</div>

			<div class="admin-menu-toggle" onclick="toggleAdminMenu()">
				<span></span>
				<span></span>
				<span></span>
			</div>

			<ul class="admin-navbar-links">
				<li><a href="adminDashboard.jsp">Dashboard</a></li>
				<li><a href="adminManageBooking.jsp">Bookings</a></li>
				<li><a href="adminRetrieveMember.jsp">Users</a></li>
				<li><a href="adminRetrieveServices.jsp">Services</a></li>
				<li><a href="adminRetrieveAllCategories.jsp">Categories</a></li>
				<li><a href="#">Customer Feedback</a></li>
				<li><a href="logout.jsp">Logout</a></li>
			</ul>

		</div>
	</nav>
</header>

<script>
	function toggleAdminMenu() {
		const navbar = document.querySelector(".admin-navbar-links");
		navbar.classList.toggle("show");
	}
</script>