<!--      JAD-CA1
Class-DIT/FT/2A/23
Student Name: Thiri Lae Win
Admin No.: P2340739  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/adminNavbar.css">
<title>Insert title here</title>
</head>
<body>

</head>
<body>
<div class="navbar">
        <h1>Cleaning Service</h1>
        <div class="menu-toggle">Menu</div>
        <ul>
            <li><a href="adminDashboard.jsp">Dashboard</a></li>
			<li><a href= "<%=request.getContextPath()%>/SortBookingByDateAndIdServlet">Manage Bookings</a></li>
            <li><a href="adminRetrieveMember.jsp">Users</a>
            <li><a href="adminRetrieveServices.jsp">Services</a></li>
            <li><a href="adminRetrieveAllCategories.jsp">Categories</a></li>
            <li><a href="#">Customer Feedback</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </div>
</body>
</html>