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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Details</title>
<link rel="stylesheet" href="../../jad/css/adminManageBookingDetails.css">
<%if(request.getAttribute("message") != null){
	%>
	
	    <script type="text/javascript">
        alert("<%=request.getAttribute("message") %>");
    </script>
	<%
	
} %>

</head>
<body>

<%
Booking booking = new Booking();
booking = (Booking) request.getAttribute("booking");
%>
	    <div class="container">
	            	<form action = "<%=request.getContextPath()%>/UpdateBookingDateAndTimeForAdminServlet" method="POST">
	    
	        <h1>Booking Details</h1>
	        <div class="details">
	            <div class="details-item">
	                <span class="label">Booking ID:</span>
	                <span class="value"><%=booking.getId() %></span>
	            </div>
	            <div class="details-item">
	                <span class="label">Customer Name:</span>
	                <span class="value"><%=booking.getCustomerName()%></span>
	            </div>
	            <div class="details-item">
	                <span class="label">Service Name:</span>
	                <span class="value"><%=booking.getServiceName()%></span>
	            </div>
	            <div class="details-item">
	                <span class="label">Special Request:</span>
	                <span class="value"><%=booking.getSpecialRequest() %></span>
	            </div>
	            <div class="details-item">
	                <span class="label">Booking Date:</span>
            		<input class="value" type="date" value="<%=booking.getDate()%>" name="bookingDate">
	            </div>
	            <div class="details-item">
	                <span class="label">Booking Time:</span>
            		<input class="value" type="time" value="<%=booking.getTime() %>" name="bookingTime">
	            </div>
	            <div class="details-item">
	                <span class="label">Status:</span>
	                <span class="value"><%=booking.getStatus() %></span>
	            </div>
	            <div class="details-item">
	                <span class="label">Price:</span>
	                <span class="value"><%=booking.getTotal_price() %></span>
	            </div>
	        </div>
		        <input type="hidden" name="bookingId" value="<%= booking.getId() %>">
		        <%
		        String bookingDateParam = request.getParameter("bookingDate");
		        String bookingTimeParam = request.getParameter("bookingTime");

		        // Check if bookingDate is null, if so use the value from the booking object
		        if (bookingDateParam == null) {
		            bookingDateParam = booking.getDate();
		        }

		        // Check if bookingTime is null, if so use the value from the booking object
		        if (bookingTimeParam == null) {
		            bookingTimeParam = booking.getTime();
		        }
		    	%>

        		<button type="submit" class="update-btn">Update</button>
            </form>
	        
	        <form action="<%=request.getContextPath()%>/DeleteBookingForAdminServlet">
	        	<input type="hidden" name="bookingId" value="<%= booking.getId() %>">
       			<button type="submit" class="delete-btn">Delete</button>
	        </form>
	        
	        <a class="back-btn" href="<%=request.getContextPath()%>/SortAndFilterBookingByDateAndIdServlet">Back to List</a>
	    </div>
</body>
</html>
