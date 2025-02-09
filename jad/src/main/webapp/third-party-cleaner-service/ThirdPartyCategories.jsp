<%@ page import="com.cleaningService.model.Category" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/services.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
<%@ include file="header.jsp" %>

<%
    // Retrieve the categories attribute
    List<Category> categories = (List<Category>) request.getAttribute("categories");

    if (categories == null || categories.isEmpty()) {
        System.out.println("DEBUG: No categories available in JSP.");
        categories = new ArrayList<>();
    } else {
        System.out.println("DEBUG: Categories found in JSP: " + categories.size());
        for (Category category : categories) {
            System.out.println("DEBUG: Category - ID: " + category.getId() + ", Name: " + category.getCategoryName());
        }
    }
%>

<section class="services" style="background-color: #e6f7ff; padding: 20px;">
    <h1 style="text-align: center; color: #004d80;">Service Categories</h1>
    <div class="services-container" style="display: flex; flex-wrap: wrap; justify-content: center; gap: 20px;">
        <% if (!categories.isEmpty()) {
            for (Category category : categories) { %>
                <div class="service-card" style="background-color: #f0fbff; border: 1px solid #cceeff; padding: 15px; border-radius: 8px; text-align: center; width: 250px;">
                    <!-- Display image, name, and description of the category -->
                    <img src="<%= request.getContextPath() + category.getImage() %>" alt="<%= category.getCategoryName() %>" style="max-width: 100%; height: auto; border-radius: 8px;">
                    <h2 style="color: #005580; margin: 10px 0;"><%= category.getCategoryName() %></h2>
                    <p style="color: #004d66;"><%= category.getDescription() %></p>
                    <a href="<%= request.getContextPath() %>/ThirdParty_GetServicesByCategoryServlet?category_id=<%= category.getId() %>" style="display: inline-block; background-color: #0077b3; color: #ffffff; padding: 8px 12px; border-radius: 5px; text-decoration: none; font-weight: bold;">More Info</a>
                </div>
        <%  } 
        } else { %>
            <p style="text-align: center; color: #004d66;">No categories available.</p>
        <% } %>
    </div>
</section>

<jsp:include page="../html/footer.html" />
