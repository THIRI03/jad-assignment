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
<%@ include file="authCheck.jsp" %>
<%@ include file="../html/adminNavbar.html" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Service</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .card {
        background-color: white;
        width: 100%;
        max-width: 600px;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    h1 {
        text-align: center;
        margin-bottom: 20px;
    }
    form {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }
    label {
        font-weight: bold;
    }
    input, select, textarea {
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    button {
        padding: 10px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    button:hover {
        background-color: #0056b3;
    }
    .message {
        text-align: center;
        font-size: 18px;
        margin-top: 10px;
        color: green;
    }
    .error {
        color: red;
    }
</style>
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
        <textarea id="description" name="description" rows="4" required></textarea><br>

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
