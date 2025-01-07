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
        out.println("<p style='color:red;'>Please log in to update feedback.</p>");
        return;
    }

    // Retrieve parameters from the form
    String feedbackId = request.getParameter("feedbackId");
    String comments = request.getParameter("comments");
    int rating = Integer.parseInt(request.getParameter("rating"));

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(
                 "UPDATE feedback SET comments = ?, rating = ? WHERE feedback_id = ? AND user_id = ?")) {
        stmt.setString(1, comments);
        stmt.setInt(2, rating);
        stmt.setInt(3, Integer.parseInt(feedbackId));
        stmt.setInt(4, userId);

        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("yourFeedback.jsp");
        } else {
            out.println("<p style='color:red;'>Error updating feedback. Please try again.</p>");
        }
    } catch (SQLException e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>
