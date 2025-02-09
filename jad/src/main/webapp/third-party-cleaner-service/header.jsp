<%@ page session="true" %>
<%@ page import="jakarta.servlet.http.Cookie" %>

<%
    // Retrieve session attributes
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
%>

<header>
    <!-- Third-Party Navbar -->
    <nav class="navbar navbar-expand-lg" style="background-color: #004080;">
        <div class="container-fluid">
            <!-- Logo -->
            <a class="navbar-brand" href="<%= request.getContextPath() %>/third-party-cleaner-service/ThirdPartyHome.jsp" style="color: #ffffff; font-weight: bold;">
                JOJO Job Agency
            </a>

            <!-- Toggle button for mobile -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon" style="color: #ffffff;"></span>
            </button>

            <!-- Navbar links -->
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <!-- Home link -->
                    <li class="nav-item">
                  <a class="nav-link" href="<%= request.getContextPath() %>/ThirdParty_GetAllCategoriesServlet" style="color: #ffffff;">Services By Categories</a>
                  
                    </li>

                    <!-- Bookings link -->
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/LoginCleanerServlet" style="color: #ffffff;">Bookings</a>
                    </li>

                    <!-- Login/Logout links -->
                    <%
                        if (username == null) { // User is not logged in
                    %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/cleanerLogin.jsp" style="color: #ffffff;">Login</a>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%= request.getContextPath() %>/cleanerLogout.jsp" style="color: #ffffff;">Logout</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
</header>
