<%-- 
    JAD-CA2
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
<%-- <%@ include file="../html/adminNavbar.html" %>
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Service</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/adminCreateService.css">
</head>
<body>

<%
	boolean isCreated = false;
	
%>
<form action="<%=request.getContextPath()%>/CreateNewServiceForAdminServlet" method="post" enctype="multipart/form-data">
	<div class="card">
	    <h1>Create New Service</h1>
	        <label for="serviceName">Service Name:</label>
	        <input type="text" id="serviceName" name="serviceName" required><br>
	
	        <label for="description">Description:</label>
	        <input type="text" id="description" name="description" rows="4" required><br>
	
	        <label for="price">Price (USD):</label>
	        <input type="number" id="price" name="price" step="0.01" required><br>
	
	        <label for="category">Category:</label>
	        <select id="category" name="category" required>
	            <option value="">-- Select a Category --</option>
	            <%
	            	CategoryDAO categoryDAO = new CategoryDAO();
	               
	            List<Category> categories = categoryDAO.getAllCategory();
	                for(Category category: categories){
	            %>
	                <option value="<%= category.getId() %>"><%= category.getCategoryName() %></option>
	            <%
	            }
	            %>
	        </select><br>
	        <label for="serviceImage">Service Image:</label>
	        <input type="file" id="serviceImage" name="serviceImage" required><br><br>
	
	        <button type="submit">Add Service</button>
	        <a href="adminRetrieveServices.jsp" style="text-decoration: none;">Go back to the service list</a>
	        
		</div>
</form>
</body>
</html>
