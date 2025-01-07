<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %> 
<%@ include file="check.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.util.DBConnection, com.cleaningService.dao.FeedbackDAO" %>
<!DOCTYPE html>
<html>
<head>
    <title>Give Feedback</title>
    <link rel="stylesheet" href="../css/home.css"> 
    <link rel="stylesheet" href="../css/feedback.css"> 
</head>
<body>
    <div class="feedback-page"> 
        <div class="feedback-container">
            <h1>Give Feedback</h1>
            <%
            // Ensure user is logged in
            if (userId == null) {
                out.println("<p style='color:red;'>Please log in to give feedback.</p>");
                return;
            }

            // Get bookingId and subServiceId from the request
            String bookingId = request.getParameter("bookingId");
            String subServiceId = request.getParameter("subServiceId");

            if (bookingId == null || subServiceId == null) {
                out.println("<p style='color:red;'>Invalid request. Missing parameters.</p>");
                return;
            }

            String serviceName = "";
            String subServiceName = "";

            // Fetch service and sub-service names
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement stmt = conn.prepareStatement(
                         "SELECT s.service_name, ss.sub_service_name " +
                         "FROM sub_service ss " +
                         "INNER JOIN service s ON ss.service_id = s.service_id " +
                         "WHERE ss.sub_service_id = ?")) {
                stmt.setInt(1, Integer.parseInt(subServiceId));
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        serviceName = rs.getString("service_name");
                        subServiceName = rs.getString("sub_service_name");
                    }
                }
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Error fetching service details: " + e.getMessage() + "</p>");
                return;
            }

            // Display success or error messages
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.println("<p style='color:green;'>" + message + "</p>");
            }

            String error = (String) request.getAttribute("error");
            if (error != null) {
                out.println("<p style='color:red;'>" + error + "</p>");
            }
            %>

            <!-- Feedback Form -->
            <form method="post">
                <p>Service: <%= serviceName %> - <%= subServiceName %></p>
                <input type="hidden" name="bookingId" value="<%= bookingId %>">
                <input type="hidden" name="subServiceId" value="<%= subServiceId %>">

                <!-- Star Rating -->
                <label for="rating">Rate the Service:</label>
                <div class="star-rating">
                    <input type="radio" id="star5" name="rating" value="5"><label for="star5">★</label>
                    <input type="radio" id="star4" name="rating" value="4"><label for="star4">★</label>
                    <input type="radio" id="star3" name="rating" value="3"><label for="star3">★</label>
                    <input type="radio" id="star2" name="rating" value="2"><label for="star2">★</label>
                    <input type="radio" id="star1" name="rating" value="1" required><label for="star1">★</label>
                </div>

                <!-- Feedback Textarea -->
                <label for="feedback">Your Feedback:</label>
                <textarea id="feedback" name="feedback" rows="4" required></textarea>

                <!-- Submit Button -->
                <button type="submit" class="submit-btn">Submit Feedback</button>
            </form>

            <%
            // Handle form submission
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String feedback = request.getParameter("feedback");
                int rating = Integer.parseInt(request.getParameter("rating"));

                // Insert feedback into the database
                FeedbackDAO feedbackDAO = new FeedbackDAO();
                boolean isSuccess = feedbackDAO.addFeedback(userId, Integer.parseInt(bookingId), Integer.parseInt(subServiceId), feedback, rating);

                if (isSuccess) {
                    out.println("<p style='color:green;'>Thank you for your feedback!</p>");
                } else {
                    out.println("<p style='color:red;'>Error saving feedback. Please try again.</p>");
                }
            }
            %>
        </div>
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
