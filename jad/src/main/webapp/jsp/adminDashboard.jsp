<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win,Moe Myat Thwe
    Admin No.: P2340739,P2340362
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.cleaningService.dao.ServiceDAO"%>
<%@ page import="com.cleaningService.dao.BookingDAO"%>
<%@ page import="com.cleaningService.dao.FeedbackDAO"%>
<%@ page import="com.cleaningService.model.Booking"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Admin Dashboard</title>

	<link rel="stylesheet"
		href="<%=request.getContextPath()%>/css/adminDashboard.css?v=2">
</head>

<body>

	<%@ include file="adminNavbar.jsp"%>

	<%
	ServiceDAO serviceDAO = new ServiceDAO();
	BookingDAO bookingDAO = new BookingDAO();
	FeedbackDAO feedbackDAO = new FeedbackDAO();

	int numOfServices = serviceDAO.retrieveNumberOfServices();
	int numOfBookings = bookingDAO.retrieveBookingNum();
	int numOfFeedbacks = feedbackDAO.retrieveFeedbackNum();

	List<Booking> bookings = bookingDAO.retrieveRecentBookings(5);
	%>

	<main class="dashboard-content">

		<section class="dashboard-heading">
			<h1>Admin Dashboard</h1>
			<p>Welcome back, Admin</p>
		</section>

		<section class="summary-cards">

			<div class="summary-card">
				<h3>Total Services</h3>
				<p><%=numOfServices%></p>
			</div>

			<div class="summary-card">
				<h3>Total Bookings</h3>
				<p><%=numOfBookings%></p>
			</div>

			<div class="summary-card">
				<h3>Customer Feedback</h3>
				<p><%=numOfFeedbacks%></p>
			</div>

		</section>

		<section class="booking-section">

			<div class="section-heading">
				<h2>Recent Bookings</h2>
			</div>

			<div class="table-container">
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
						<%
						if (bookings != null && !bookings.isEmpty()) {
							for (Booking booking : bookings) {
						%>

						<tr>
							<td><%=booking.getId()%></td>
							<td><%=booking.getCustomerName()%></td>
							<td><%=booking.getServiceName()%></td>
							<td><%=booking.getDate()%></td>
							<td><%=booking.getTime()%></td>
						</tr>

						<%
							}
						} else {
						%>

						<tr>
							<td colspan="5" class="empty-message">
								No bookings available.
							</td>
						</tr>

						<%
						}
						%>
					</tbody>
				</table>
			</div>

		</section>

	</main>

</body>
</html>