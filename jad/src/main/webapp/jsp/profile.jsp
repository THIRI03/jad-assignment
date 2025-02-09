<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %>
<%@ include file="check.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*, com.cleaningService.util.DBConnection" %>
<%@ include file="authCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/profile.css">
    <script>
        function showAlert(message) {
            alert(message);
        }

        function toggleAvatarSelection() {
            const selectionDiv = document.getElementById('avatar-selection');
            selectionDiv.style.display = selectionDiv.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <%
        if (session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String name = "", email = "", phone = "Not Specified", address = "Not Specified";
        String avatarUrl = "gallery/default_avatar.jpg";
        String coverPhotoUrl = "gallery/default_cover.jpg";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?")) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    name = rs.getString("name");
                    email = rs.getString("email");
                    phone = rs.getString("phone_number") != null ? rs.getString("phone_number") : phone;
                    address = rs.getString("address") != null ? rs.getString("address") : address;
                    avatarUrl = rs.getString("avatar_url") != null ? rs.getString("avatar_url") : avatarUrl;
                    coverPhotoUrl = rs.getString("cover_photo_url") != null ? rs.getString("cover_photo_url") : coverPhotoUrl;
                }
            }
        } catch (SQLException e) {
            out.println("<p style='color:red;'>Error fetching user data: " + e.getMessage() + "</p>");
        }
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>
    <% if (successMessage != null) { %>
        <script>
            showAlert("<%= successMessage %>");
        </script>
    <% } else if (errorMessage != null) { %>
        <script>
            showAlert("<%= errorMessage %>");
        </script>
    <% } %>

    <div class="profile-container">
        <div class="profile-cover" style="background-image: url('../<%= coverPhotoUrl %>');">
            <div class="profile-avatar">
                <img src="../<%= avatarUrl %>" alt="User Avatar" id="current-avatar">
            </div>
        </div>

        <div class="profile-details">
            <h1>Welcome, <%= name %></h1>
            <form method="post" action="updateProfile.jsp">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= name %>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email %>" required>

                <label for="phone">Phone:</label>
                <input type="text" id="phone" name="phone" value="<%= phone %>">

                <label for="address">Address:</label>
                <textarea id="address" name="address" rows="3"><%= address %></textarea>

                <div class="profile-buttons">
                    <button type="submit" class="update-profile-btn">Update Profile</button>
                    <button type="button" class="change-avatar-btn" onclick="toggleAvatarSelection()">Change Avatar</button>
                </div>
            </form>
        </div>

        <div id="avatar-selection" style="display: none;">
            <h3>Select Your Avatar</h3>
            <form method="post" action="updateAvatar.jsp">
                <div class="avatar-options">
                    <label>
                        <input type="radio" name="avatar" value="gallery/avatar1.jpg">
                        <img src="../gallery/avatar1.jpg" alt="Avatar 1">
                    </label>
                    <label>
                        <input type="radio" name="avatar" value="gallery/avatar2.jpg">
                        <img src="../gallery/avatar2.jpg" alt="Avatar 2">
                    </label>
                    <label>
                        <input type="radio" name="avatar" value="gallery/avatar3.jpg">
                        <img src="../gallery/avatar3.jpg" alt="Avatar 3">
                    </label>
                    <label>
                        <input type="radio" name="avatar" value="gallery/avatar4.jpg">
                        <img src="../gallery/avatar4.jpg" alt="Avatar 4">
                    </label>
                    <label>
                        <input type="radio" name="avatar" value="gallery/avatar5.jpg">
                        <img src="../gallery/avatar5.jpg" alt="Avatar 5">
                    </label>
                </div>
                <button type="submit" class="save-avatar-btn">Save Avatar</button>
            </form>
        </div>
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
