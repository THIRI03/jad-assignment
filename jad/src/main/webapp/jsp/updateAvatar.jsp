<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="check.jsp" %>
<%@ page import="java.sql.*, com.cleaningService.util.DBConnection" %>
<%@ include file="authCheck.jsp" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String selectedAvatar = request.getParameter("avatar");

    if (selectedAvatar != null) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "UPDATE users SET avatar_url = ? WHERE id = ?")) {
            stmt.setString(1, selectedAvatar);
            stmt.setInt(2, userId);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("profile.jsp?message=Avatar updated successfully!");
            } else {
                out.println("<p style='color:red;'>Error updating avatar. Please try again.</p>");
            }
        } catch (SQLException e) {
            out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
        }
    } else {
        out.println("<p style='color:red;'>No avatar selected. Please select an avatar.</p>");
    }
%>
