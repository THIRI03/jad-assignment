<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "jakarta.servlet.http.HttpSession" %>
<%@ page import = "com.cleaningService.model.Category" %> 
<%@ page import = "com.cleaningService.model.Service" %> 
<%@ page import = "com.cleaningService.dao.ServiceDAO" %> 
<%@ page import = "com.cleaningService.dao.CategoryDAO" %> 
<%@ page import = "java.util.List" %>
<%@ include file="authCheck.jsp" %>
<%@ include file="../html/adminNavbar.html" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Service</title>
<style>

body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

.container {
	margin-top: 60px;
    width: 80%;
    margin: 0 auto;
    padding-top: 50px;
}

h2 {
    text-align: center;
    color: #333;
    font-size: 24px;
    margin-bottom: 20px;
}

form {
    background-color: #fff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    max-width: 600px;
    margin: 0 auto;
}

label {
    display: block;
    margin-bottom: 8px;
    color: #333;
    font-size: 16px;
}

input[type="text"], input[type="number"], textarea, select {
    width: 100%;
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
}

input[type="text"]:focus, input[type="number"]:focus, textarea:focus, select:focus {
    outline: none;
    border-color: #007bff;
}

textarea {
    resize: vertical;
}

input[type="submit"] {
    width: 100%;
    padding: 15px;
    background-color: #007bff;
    border: none;
    color: white;
    font-size: 18px;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #0056b3;
}

/* Styling for the back link */
a {
    display: block;
    text-align: center;
    margin-top: 20px;
    color: #007bff;
    text-decoration: none;
    font-size: 16px;
}

a:hover {
    text-decoration: underline;
}
</style>
</head>
<body>
<div class="container">


<%
    // Retrieve serviceId from the URL parameter
    String serviceIdStr = request.getParameter("serviceId");
    int serviceId = Integer.parseInt(serviceIdStr);

    // Fetch the service details from the database using serviceId
    ServiceDAO serviceDAO = new ServiceDAO();
    Service service = serviceDAO.retrieveServiceById(serviceId);
%>

<h2>Update Service</h2>

<!-- The form to update service details -->
<form method="post" action="<%=request.getContextPath() %>/UpdateServiceServlet">
    <!-- Hidden input to pass the serviceId -->
    <input type="hidden" name="serviceId" value="<%= service.getId() %>">

    <label for="serviceName">Service Name</label>
    <input type="text" id="serviceName" name="serviceName" value="<%= service.getName() %>" required>

    <label for="description">Description</label>
    <textarea id="description" name="description" rows="4" required><%= service.getDescription() %></textarea>

    <label for="price">Price</label>
    <input type="number" id="price" name="price" value="<%= service.getPrice() %>" step="0.01" required>

    <label for="category">Category:</label>
    <select id="category" name="category" required>
        <option value="">-- Select a Category --</option>
        <%
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categories = categoryDAO.getAllCategory();
            for(Category category : categories){
        %>
            <option value="<%= category.getId() %>" <%= (category.getId() == service.getCategory_id()) ? "selected" : "" %>><%= category.getCategoryName() %></option>
        <%
            }
        %>
    </select><br>

    <input type="submit" value="Update Service">
</form>

</div>

<a href="adminRetrieveServices.jsp">Go back to the service list</a>
</body>
</html>
