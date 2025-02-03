<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.cleaningService.dao.ServiceDAO" %>
<%@ page import="com.cleaningService.dao.CategoryDAO" %>
<%@ page import="com.cleaningService.model.Service" %>
<%@ page import="com.cleaningService.model.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%@ page import="jakarta.servlet.http.Part" %>
<%-- <%@ include file="authCheck.jsp" %>--%>
<%-- <%@ include file="../html/adminNavbar.html" %>
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Service</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/adminCreateService.css">
</head>
<body>

<%
    ServiceDAO serviceDAO = new ServiceDAO();
    CategoryDAO categoryDAO = new CategoryDAO();

    if("POST".equalsIgnoreCase(request.getMethod())){
        try{
            String name = request.getParameter("serviceName");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String categoryStr = request.getParameter("category");
            String image = "/gallery/default-image.jpg";
            double price = Double.parseDouble(priceStr);
            int category = Integer.parseInt(categoryStr);

            Service service = new Service(name, description, price, category, image);
            boolean created = serviceDAO.createService(service);

            if(created){
%>
                <div class="message">Service created successfully!</div>
                
<%
			response.sendRedirect("adminRetrieveAllCategories.jsp");
            }else{
%>
                <div class="message error">Service not created! Please try again.</div>
<%
            }
        } catch (Exception e) {
%>
            <div class="message error">Error processing form data: <%= e.getMessage() %></div>
<%
        }
    }
%>

<div class="card">
    <h1>Create New Service</h1>
    <form method="POST">
        <label for="serviceName">Service Name:</label>
        <input type="text" id="serviceName" name="serviceName" required><br>

        <label for="description">Description:</label>
        <input id="description" name="description" rows="4" required><br>

        <label for="price">Price (USD):</label>
        <input type="number" id="price" name="price" step="0.01" required><br>

        <label for="category">Category:</label>
        <select id="category" name="category" required>
            <option value="">-- Select a Category --</option>
            <%
                List<Category> categories = categoryDAO.getAllCategory();
                for(Category category: categories){
            %>
                <option value="<%= category.getId() %>"><%= category.getCategoryName() %></option>
            <%
            }
            %>
        </select><br>

        <button type="submit">Add Service</button>
    </form>
</div>

</body>
</html>
