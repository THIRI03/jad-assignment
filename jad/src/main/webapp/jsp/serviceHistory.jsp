<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, java.util.*, com.cleaningService.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Booking History</title>
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/history.css">
    <style>
        .booking-history-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 20px;
        }
        .booking-card {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .booking-card:hover {
            transform: scale(1.03);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.15);
        }
        .booking-title {
            font-size: 1.8rem;
            font-weight: bold;
            color: #674636;
            margin-bottom: 10px;
        }
        .booking-details {
            font-size: 1rem;
            color: #555;
            margin: 5px 0;
        }
        .feedback-btn {
            background-color: #835945;
            color: white;
            font-size: 1rem;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            display: inline-block;
            margin-top: 20px;
            text-align: center;
        }
        .feedback-btn:hover {
            background-color: #b78c77;
            transform: scale(1.05);
        }
    </style>
</head>
<body class="service-history-page">
    <div class="service-history-container py-5">
        <h1 class="service-history-title text-center">My Booking History</h1>
        <div class="booking-history-container">
            <% 
                if (userId == null) {
                    out.println("<p class='text-center no-service-history'>Please log in to view your booking history.</p>");
                    return;
                }

                try (Connection conn = DBConnection.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(
                         "SELECT b.id AS booking_id, s.name AS service_name, b.booking_date, b.booking_time, " +
                         "b.special_request, b.total_price, b.status " +
                         "FROM bookings b " +
                         "INNER JOIN service s ON b.serviceid = s.id " +
                         "WHERE b.userid = ? " +
                         "ORDER BY b.booking_date DESC, b.booking_time DESC")) {

                    stmt.setInt(1, userId);

                    try (ResultSet rs = stmt.executeQuery()) {
                        if (!rs.isBeforeFirst()) {
                            out.println("<p class='text-center no-service-history'>No booking history found.</p>");
                        } else {
                            while (rs.next()) {
                                int bookingId = rs.getInt("booking_id");
                                String serviceName = rs.getString("service_name");
                                String bookingDate = rs.getString("booking_date");
                                String bookingTime = rs.getString("booking_time");
                                String specialRequest = rs.getString("special_request");
                                double totalPrice = rs.getDouble("total_price");
                                String status = rs.getString("status");
            %>
            <div class="booking-card">
                <h2 class="booking-title">Booking ID: <%= bookingId %></h2>
                <h3 class="booking-title"><%= serviceName %></h3>
                <p class="booking-details"><strong>Date:</strong> <%= bookingDate %></p>
                <p class="booking-details"><strong>Time:</strong> <%= bookingTime %></p>
                <p class="booking-details"><strong>Special Request:</strong> <%= (specialRequest != null ? specialRequest : "None") %></p>
                <p class="booking-details"><strong>Total Price:</strong> $<%= totalPrice %></p>
                <p class="booking-details"><strong>Status:</strong> <%= status %></p>
                <% if ("Completed".equalsIgnoreCase(status)) { %>
                    <form method="get" action="feedback.jsp">
                        <input type="hidden" name="bookingId" value="<%= bookingId %>">
                        <button type="submit" class="feedback-btn">Give Feedback</button>
                    </form>
                <% } %>
            </div>
            <%
                            }
                        }
                    }
                } catch (SQLException e) {
                    out.println("<p class='text-center no-service-history'>Error retrieving booking history: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
