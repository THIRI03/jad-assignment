<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.util.DBConnection" %>
<%@ include file="authCheck.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Your Feedback</title>
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/yourFeedback.css">
</head>
<body>
    <div class="feedback-page">
        <div class="feedback-header">
            <h1>Your Feedback</h1>
            <a href="serviceHistory.jsp" class="create-feedback-btn">+ Create Feedback</a>
        </div>
        <div class="feedback-list">
            <% 
            if (userId == null) {
                out.println("<p style='color:red;'>Please log in to view your feedback.</p>");
                return;
            }

            try (Connection conn = DBConnection.getConnection();
            	     PreparedStatement stmt = conn.prepareStatement(
            	         "SELECT f.id AS feedback_id, f.comment, f.rating, f.created, " +
            	         "b.booking_date, s.name AS service_name " +
            	         "FROM feedback f " +
            	         "INNER JOIN bookings b ON f.bookingid = b.id " +
            	         "INNER JOIN service s ON f.serviceid = s.id " +
            	         "WHERE f.userid = ? ORDER BY f.created DESC")) {

            	    stmt.setInt(1, userId);

            	    try (ResultSet rs = stmt.executeQuery()) {
            	        if (!rs.isBeforeFirst()) {
            	            out.println("<p class='no-feedback-msg'>You have not left any feedback yet.</p>");
            	        } else {
            	            while (rs.next()) {
            	                int feedbackId = rs.getInt("feedback_id");
            	                String serviceName = rs.getString("service_name");
            	                String feedbackDate = rs.getString("created");
            	                String comment = rs.getString("comment");  
            	                int rating = rs.getInt("rating");

            %>
            <div class="feedback-card">
                <h2><%= serviceName %></h2>
                <p><strong>Date:</strong> <%= feedbackDate %></p>
                <p class="rating-stars"><strong>Rating:</strong> <%= rating %> ★</p>
                <p><strong>Comments:</strong> <%= comment %></p>
                <!-- Update and Delete Buttons -->
                <div class="feedback-actions">
                    <form action="updateFeedback.jsp" method="get" style="display: inline;">
                        <input type="hidden" name="feedbackId" value="<%= feedbackId %>">
                        <button type="submit" class="update-btn">Update</button>
                    </form>
                    <form action="deleteFeedback.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="feedbackId" value="<%= feedbackId %>">
                        <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this feedback?');">Delete</button>
                    </form>
                </div>
            </div>
            <% 
                        }
                    }
                }
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Error retrieving feedback: " + e.getMessage() + "</p>");
            }
            %>
        </div>
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
