<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "com.cleaningService.dao.BookingDAO" %>
<%@page import = "com.cleaningService.model.Booking" %>
<%@ page import = "java.util.List" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bookings-Admin</title>
</head>
<body>

<%
BookingDAO bookingDAO = new BookingDAO();
List<Booking>bookings = bookingDAO.retrieveAllBookings();

System.out.println("ok");
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

</body>
</html>