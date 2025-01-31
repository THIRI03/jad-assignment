<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%-- <%@ include file="authCheck.jsp" %> --%>
<%@page import = "com.cleaningService.dao.ServiceDAO" %>
<%@page import = "com.cleaningService.dao.BookingDAO" %>
<%@page import = "com.cleaningService.dao.FeedbackDAO" %>
<%@page import = "com.cleaningService.model.Booking" %>
<%@ include file="../html/adminNavbar.html" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<link rel="stylesheet" href="../css/adminDashboard.css">

</head>
<body>
<%
/* Integer loggedInUserRoleId = (Integer) session.getAttribute("userRole");
if(loggedInUserRoleId == null || loggedInUserRoleId == 2){
    response.sendRedirect("login.jsp");
    return;    
} */

ServiceDAO serviceDAO = new ServiceDAO();
BookingDAO bookingDAO = new BookingDAO();
FeedbackDAO feedbackDAO = new FeedbackDAO();
int numOfServices = serviceDAO.retrieveNumberOfServices();
int numOfBookings = bookingDAO.retrieveBookingNum();
int numOfFeedbacks = feedbackDAO.retrieveFeedbackNum();
%>
    
<!-- Main Content -->
<div class="main-content">
    <header>
        <h1>Admin Dashboard</h1>
        <p>Welcome back, Admin!</p>
    </header>

    <!-- Summary Cards -->
    <div class="summary-cards">
        <div class="card">
            <h3>Total Services</h3>
            <p><%= numOfServices %></p>
        </div>
    
        <div class="card">
            <h3>Total Bookings</h3>
            <p><%= numOfBookings %></p>
        </div>
        
        <div class="card">
            <h3>Customer Feedbacks</h3>
            <p><%= numOfFeedbacks %></p>
        </div>    
    </div>

    <!-- Bookings Table -->
    <%
    List<Booking> bookings = bookingDAO.retrieveAllBookings();
	%>

    <h2>Recent Bookings</h2>
    <table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Customer Name</th>
                <th>Service</th>
                <th>Date</th>
                <th>Time</th>
            </tr>
        </thead>
        <tbody>
            <%-- Loop through all bookings and display them in table rows --%>
            <%
                for (Booking booking : bookings) {
            %>
            <tr>
                <td><%= booking.getId() %></td>
                <td><%= booking.getCustomerName() %></td>
                <td><%= booking.getServiceName() %></td>
                <td><%= booking.getDate() %></td>
                <td><%= booking.getTime() %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>


<script>
    const menuToggle = document.querySelector('.menu-toggle');
    const navMenu = document.querySelector('.navbar ul');

    menuToggle.addEventListener('click', () => {
        navMenu.classList.toggle('show');
    });
</script>

</body>
</html>
