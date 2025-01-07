<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %>
<%@ include file="check.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, java.util.*, com.cleaningService.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Service History</title>
    <link rel="stylesheet" href="../css/home.css"> <!-- Include your existing home page styles -->
    <link rel="stylesheet" href="../css/history.css"> <!-- Include updated theme-specific styles -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
                         "SELECT b.booking_id, s.service_name, ss.sub_service_name, b.created_at, b.special_request, b.sub_service_id " +
                         "FROM booking b " +
                         "INNER JOIN sub_service ss ON b.sub_service_id = ss.sub_service_id " +
                         "INNER JOIN service s ON ss.service_id = s.service_id " +
                         "WHERE b.user_id = ? ORDER BY b.created_at DESC")) {
                stmt.setInt(1, userId);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (!rs.isBeforeFirst()) {
                        out.println("<p class='text-center no-service-history'>No service history found.</p>");
                    } else {
                        while (rs.next()) {
                            int bookingId = rs.getInt("booking_id");
                            String serviceName = rs.getString("service_name");
                            String subServiceName = rs.getString("sub_service_name");
                            String bookingDate = rs.getString("created_at");
                            String specialRequest = rs.getString("special_request");
                            int subServiceId = rs.getInt("sub_service_id");
            %>
            <div class="col">
                <div class="service-history-card">
                    <div class="service-card-body">
                        <h2 class="service-title"><%= serviceName %> - <%= subServiceName %></h2>
                        <p class="service-details"><strong>Booking Date:</strong> <%= bookingDate %></p>
                        <p class="service-details"><strong>Special Request:</strong> <%= (specialRequest != null ? specialRequest : "None") %></p>
                        <form method="get" action="feedback.jsp">
                            <input type="hidden" name="bookingId" value="<%= bookingId %>">
                            <input type="hidden" name="subServiceId" value="<%= subServiceId %>">
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
