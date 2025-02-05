<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, java.util.*, com.cleaningService.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Service History</title>
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/history.css">
</head>
<body class="service-history-page">
    <div class="service-history-container py-5">
        <h1 class="service-history-title text-center">My Service History</h1>
        <div class="service-history-row row row-cols-1 row-cols-md-3 g-4">
            <% 
               
                if (userId == null) {
                    out.println("<p class='text-center no-service-history'>Please log in to view your service history.</p>");
                    return;
                }

                try (Connection conn = DBConnection.getConnection();
                     PreparedStatement stmt = conn.prepareStatement(
                         "SELECT b.id AS booking_id, s.name AS service_name, b.booking_date, b.booking_time, b.special_request, b.total_price " +
                         "FROM bookings b " +
                         "INNER JOIN service s ON b.serviceid = s.id " +
                         "WHERE b.userid = ? AND b.status = 'Completed' " +
                         "ORDER BY b.booking_date DESC, b.booking_time DESC")) {

                    stmt.setInt(1, userId);

                    try (ResultSet rs = stmt.executeQuery()) {
                        if (!rs.isBeforeFirst()) {
                            out.println("<p class='text-center no-service-history'>No completed service history found.</p>");
                        } else {
                            while (rs.next()) {
                                int bookingId = rs.getInt("booking_id");
                                String serviceName = rs.getString("service_name");
                                String bookingDate = rs.getString("booking_date");
                                String bookingTime = rs.getString("booking_time");
                                String specialRequest = rs.getString("special_request");
                                double totalPrice = rs.getDouble("total_price");
            %>
            <div class="col">
                <div class="service-history-card">
                    <div class="service-card-body">
                        <h2 class="service-title"><%= serviceName %></h2>
                        <p class="service-details"><strong>Date:</strong> <%= bookingDate %></p>
                        <p class="service-details"><strong>Time:</strong> <%= bookingTime %></p>
                        <p class="service-details"><strong>Special Request:</strong> <%= (specialRequest != null ? specialRequest : "None") %></p>
                        <p class="service-details"><strong>Total Price:</strong> $<%= totalPrice %></p>
                        <form method="get" action="feedback.jsp">
                            <input type="hidden" name="bookingId" value="<%= bookingId %>">
                            <button type="submit" class="custom-btn service-feedback-btn">Give Feedback</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                            }
                        }
                    }
                } catch (SQLException e) {
                    out.println("<p class='text-center no-service-history'>Error retrieving service history: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
