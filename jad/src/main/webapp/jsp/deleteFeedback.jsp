<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="check.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.cleaningService.util.DBConnection" %>
<%
    // Retrieve userId from the session
    Integer userId = (Integer) session.getAttribute("userId");

    // If userId is null, the user is not logged in
    if (userId == null) {
        out.println("<p style='color:red;'>Please log in to delete feedback.</p>");
        return;
    }

    // Retrieve feedbackId from the request
    String feedbackId = request.getParameter("feedbackId");

    if (feedbackId == null || feedbackId.isEmpty()) {
        out.println("<p style='color:red;'>Invalid request. Feedback ID is missing.</p>");
        return;
    }

    // Perform the deletion in the database
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(
                 "DELETE FROM feedback WHERE feedback_id = ? AND user_id = ?")) {
        stmt.setInt(1, Integer.parseInt(feedbackId));
        stmt.setInt(2, userId);

        int rowsDeleted = stmt.executeUpdate();
        if (rowsDeleted > 0) {
            // Redirect to "Your Feedback" page after successful deletion
            response.sendRedirect("yourFeedback.jsp");
        } else {
            out.println("<p style='color:red;'>Error deleting feedback or you do not have permission to delete this feedback.</p>");
        }
    } catch (SQLException e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
