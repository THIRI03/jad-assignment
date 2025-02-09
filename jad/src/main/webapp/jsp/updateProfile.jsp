<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="check.jsp" %>
<%@ page import="java.sql.*, com.cleaningService.util.DBConnection" %>
<%@ include file="authCheck.jsp" %>

<%
    // Retrieve the current userId from session
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve form parameters
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phoneNumber = request.getParameter("phone_number");  // Updated to match database column name
    String address = request.getParameter("address");

    // Update user information in the database
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(
             "UPDATE users SET name = ?, email = ?, phone_number = ?, address = ? WHERE id = ?")) {  // Updated column name to phone_number
        stmt.setString(1, name);
        stmt.setString(2, email);
        stmt.setString(3, phoneNumber);  // Updated column reference to phone_number
        stmt.setString(4, address);
        stmt.setInt(5, userId);

        int rowsUpdated = stmt.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("profile.jsp?message=Profile updated successfully!");
        } else {
            out.println("<p style='color:red;'>Error updating profile. Please try again.</p>");
        }
    } catch (SQLException e) {
        out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
    }
%>
