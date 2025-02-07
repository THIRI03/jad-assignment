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
</head>
<body>
    <div class="container">
        <h1>Booking Details</h1>
        <div class="details">
            <div class="details-item">
                <span class="label">Booking ID:</span>
                <span class="value">${booking.id}</span>
            </div>
            <div class="details-item">
                <span class="label">Customer Name:</span>
                <span class="value">${booking.customerName}</span>
            </div>
            <div class="details-item">
                <span class="label">Service Name:</span>
                <span class="value">${booking.serviceName}</span>
            </div>
            <div class="details-item">
                <span class="label">Special Request:</span>
                <span class="value">${booking}</span>
            </div>
            <div class="details-item">
                <span class="label">Booking Date:</span>
                <span class="value">${booking.date}</span>
            </div>
            <div class="details-item">
                <span class="label">Booking Time:</span>
                <span class="value">${booking.time}</span>
            </div>
            <div class="details-item">
                <span class="label">Status:</span>
                <span class="value">${booking.status}</span>
            </div>
        </div>
        <a class="back-btn" href="/adminManageBooking.jsp">Back to List</a>
    </div>
</body>
</html>
