<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %>
<%@ include file="authCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Feedback</title>
    <link rel="stylesheet" href="../css/home.css"> <!-- Reuse core styles -->
    <link rel="stylesheet" href="../css/feedback.css"> <!-- Consistent feedback styling -->
</head>
<body>
    <div class="feedback-page">
        <div class="feedback-container">
            <h1>Update Feedback</h1>
            <%
            // Ensure the user is logged in
            if (userId == null) {
                out.println("<p style='color:red;'>Please log in to update feedback.</p>");
                return;
            }

            // Retrieve feedbackId and fetch feedback details
            String feedbackId = request.getParameter("feedbackId");
            String comments = "";
            int rating = 0;

            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                         "SELECT comment, rating FROM feedback WHERE id = ? AND userid = ?")) {
                stmt.setInt(1, Integer.parseInt(feedbackId));
                stmt.setInt(2, userId);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        comments = rs.getString("comment");  // Corrected column name
                        rating = rs.getInt("rating");
                    } else {
                        out.println("<p style='color:red;'>Feedback not found or unauthorized access.</p>");
                        return;
                    }
                }
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Error fetching feedback: " + e.getMessage() + "</p>");
                return;
            }
            %>

            <!-- Feedback Update Form -->
            <form method="post" action="processUpdateFeedback.jsp">
                <input type="hidden" name="feedbackId" value="<%= feedbackId %>">

                <!-- Star Rating -->
                <label for="rating">Rate the Service:</label>
                <div class="star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                        <input type="radio" id="star<%= i %>" name="rating" value="<%= i %>" <%= (i == rating ? "checked" : "") %>>
                        <label for="star<%= i %>">★</label>
                    <% } %>
                </div>

                <!-- Feedback Textarea -->
                <label for="comment">Your Feedback:</label>
                <textarea id="comment" name="comment" rows="4" required><%= comments %></textarea>

                <!-- Submit Button -->
                <button type="submit" class="submit-btn">Update Feedback</button>
            </form>
        </div>
    </div>
</body>
</html>
