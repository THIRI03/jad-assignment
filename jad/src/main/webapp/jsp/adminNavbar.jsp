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
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/adminNavbar.css">
</head>
<body>

</head>
<body>
<div class="navbar">
        <h1>Cleaning Service</h1>
        <div class="menu-toggle">Menu</div>
        <ul>
            <li><a href="/jad/jsp/adminDashboard.jsp">Dashboard</a></li>
			<li><a href= "<%=request.getContextPath()%>/SortAndFilterBookingByDateAndIdServlet">Manage Bookings</a></li>
            <li><a href="/jad/jsp/adminRetrieveMember.jsp">Users</a>
            <li><a href="/jad/jsp/adminRetrieveServices.jsp">Services</a></li>
            <li><a href="/jad/jsp/adminRetrieveAllCategories.jsp">Categories</a></li>
            <li><a href="<%=request.getContextPath()%>/GetAllFeedbacksForAdminServlet">Customer Feedback</a></li>
            <li><a href="/jad/jsp/logout.jsp">Logout</a></li>
        </ul>
    </div>
</body>
</html>