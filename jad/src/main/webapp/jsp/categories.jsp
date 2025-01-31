<%@ page import="com.cleaningService.model.Category" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/services.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">


<%
    // Retrieve the categories attribute
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    if (categories == null || categories.isEmpty()) {
        System.out.println("DEBUG: No categories available in JSP.");
        categories = new ArrayList<>();
    } else {
        System.out.println("DEBUG: Categories found in JSP: " + categories.size());
        // Log each category for debugging
        for (Category category : categories) {
            System.out.println("DEBUG: Category - ID: " + category.getId() + ", Name: " + category.getCategoryName());
        }
    }
%>

<section class="services">
    <h1>Service Categories</h1>
    <div class="services-container">
        <% if (!categories.isEmpty()) {
            for (Category category : categories) { %>
                <div class="service-card">
                    <!-- Display image, name, and description of the category -->
                    <img src="<%= request.getContextPath() + category.getImage() %>" alt="<%= category.getCategoryName() %>">
                    <h2><%= category.getCategoryName() %></h2>
                    <p><%= category.getDescription() %></p>
                    <a href="<%= request.getContextPath() %>/ServiceServlet?category_id=<%= category.getId() %>" class="btn btn-primary">More Info</a>
                </div>
        <%  } 
        } else { %>
            <p>No categories available.</p>
        <% } %>
    </div>
</section>

<jsp:include page="../html/footer.html" />