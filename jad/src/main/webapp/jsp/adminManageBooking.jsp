<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "com.cleaningService.dao.BookingDAO" %>
<%@page import = "com.cleaningService.model.Booking" %>
<%@ page import = "java.util.List" %>
<%@ include file="/jsp/adminNavbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookings-Admin</title>
<link rel="stylesheet" href="../jad/css/adminNavbar.css"> 
<link rel="stylesheet" href="../../jad/css/adminManageBooking.css">

</head>
<body>
<header>
    <h1>Bookings</h1>
    
    <form action="<%=request.getContextPath()%>/SortAndFilterBookingByDateAndIdServlet" method="GET">
	    <select id="sortBooking" name="sortBooking" onchange="this.form.submit()">
	    	<option value="id" <%= "id".equals(request.getParameter("sortBooking")) ? "selected" : "" %>>Booking ID</option>
            <option value="booking_date" <%= "booking_date".equals(request.getParameter("sortBooking")) ? "selected" : "" %>>Date</option>
	    </select>

    	<select id="status" name="status" onchange="this.form.submit()">
		   	<option value="All" <%= "All".equals(request.getParameter("status")) ? "selected" : "" %>>All</option>
            <option value="Not Completed" <%= "Not Completed".equals(request.getParameter("status")) ? "selected" : "" %>>Not Completed</option>
            <option value="In Progress" <%= "In Progress".equals(request.getParameter("status")) ? "selected" : "" %>>In Progress</option>
            <option value="Completed" <%= "Completed".equals(request.getParameter("status")) ? "selected" : "" %>>Completed</option>
	    </select>
    </form>
    
</header>
<%
BookingDAO bookingDAO = new BookingDAO();
List<Booking>bookings = (List<Booking>) request.getAttribute("bookings");
%>

	<table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Customer Name</th>
                <th>Service</th>
                <th>Date</th>
                <th>Time</th>
                <th>Status</th>
                <th></th>
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
                <td>
				    <form action="<%= request.getContextPath() %>/UpdateBookingStatusForAdminServlet" method="POST">
				        <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
				        <select name="statusChange" onchange="this.form.submit()">
				            <option value="Not Completed" <%= "Not Completed".equals(booking.getStatus()) ? "selected" : "" %>>Not Completed</option>
				            <option value="In Progress" <%= "In Progress".equals(booking.getStatus()) ? "selected" : "" %>>In Progress</option>
				            <option value="Completed" <%= "Completed".equals(booking.getStatus()) ? "selected" : "" %>>Completed</option>
				        </select>
				    </form>
				</td>
				<td>
                	<form action="<%=request.getContextPath() %>/GetBookingDetailsForAdminServlet" method = "POST">
				    	<input type="hidden" name="booking_id" value="<%=booking.getId()%>">
					    <button type="button" onclick="this.form.submit()">View Details</button>
					</form>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

</body>
</html>