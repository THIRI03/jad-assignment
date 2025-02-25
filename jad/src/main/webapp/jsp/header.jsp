<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%
    // Check if userId is already defined to avoid duplicate declaration
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        // Attempt to retrieve userId from cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("userId".equals(cookie.getName())) {
                    try {
                        userId = Integer.parseInt(cookie.getValue());
                        session.setAttribute("userId", userId); // Restore session userId
                    } catch (NumberFormatException e) {
                        // Handle invalid cookie value (optional)
                    }
                    break;
                }
            }
        }
    }

    // Retrieve other session attributes
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
%>
<header>
    <nav>
        <div class="navbar-container">
            <!-- Logo and Brand Name -->
            <div class="logo">
                <a href="home.jsp">
                    <img src="../gallery/ShinyLogo.jpg" alt="Shiny Logo">
                    Shiny
                </a>
            </div>

            <!-- Hamburger Menu Icon -->
            <div class="hamburger-menu" onclick="toggleMenu()">
                <span></span>
                <span></span>
                <span></span>
            </div>

            <!-- Navbar Links -->
            <ul class="navbar">
                <!-- Links for All Users -->
                <li><a href="home.jsp">Home</a></li>
                <li><a href="categories.jsp">Services</a></li>

                <% 
                if (username != null) { // User is logged in
                    if ("admin".equalsIgnoreCase(role)) { // Admin-specific links
                %>
                        <li><a href="dashboard.jsp">Dashboard</a></li>
                        <li><a href="appointments.jsp">Manage Appointments</a></li>
                        <li><a href="feedback.jsp">Manage Feedback</a></li>
                <% 
                    } else { // Customer-specific links
                %>
                        <li><a href="profile.jsp">Profile</a></li>
                        <li><a href="cart.jsp">Cart</a></li>
                        <li><a href="serviceHistory.jsp">Service History</a></li>
                        <li><a href="yourFeedback.jsp">Feedback</a></li>
                <% 
                    }
                %>
                    <!-- Common link for all logged-in users -->
                    <li><a href="logout.jsp">Logout</a></li>
                <% 
                } else { // Links for unauthenticated users
                %>
                    <li><a href="register.jsp">Register</a></li>
                    <li><a href="login.jsp">Login</a></li>
                <% } %>
            </ul>
        </div>
    </nav>
</header>

<script>
    function toggleMenu() {
        const navbar = document.querySelector('.navbar');
        navbar.classList.toggle('show');
    }
</script>
