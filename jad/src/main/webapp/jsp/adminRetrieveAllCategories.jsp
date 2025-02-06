
<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.cleaningService.model.Category" %> 
<%@ page import="com.cleaningService.dao.CategoryDAO" %>
<%-- <%@ include file="authCheck.jsp" %>--%>
<%@ include file="/jsp/adminNavbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>All Categories</title>
  <link rel="stylesheet" href="../css/adminRetrieveAllCategories.css">
</head>
<body>
<div class="main-content">
  <!-- Create New Category button -->
  <button class="create-btn" onclick="location.href='adminCreateCategory.jsp'">Create New Category</button>

    <h3>All Services</h3>
	    <div class="card-container">
	        <%  
	            CategoryDAO serviceDAO = new CategoryDAO();
	            // Retrieve the list of services from the database
	            List<Category> categories = serviceDAO.getAllCategory();
	            
	            if (categories != null && !categories.isEmpty()) {
	                for (Category category : categories) {
	        %>
	        <div class="card">
	            <img src="<%= request.getContextPath() %>/<%= category.getImage() %>" alt="Service Image">
	            <h3><%= category.getCategoryName() %></h3>
	            <p><strong>Description:</strong> <%= category.getDescription() %></p>
	
	            <!-- Update Button -->
	            <form action="adminUpdateService.jsp" method="get">
				    <input type="hidden" name="serviceId" value="<%= category.getId() %>">
				    <input type="hidden" name="action" value="update">
				    <button class="btn-update" type="submit">Update</button>
			</form>

	            
	            <!-- Upload New Image Button -->
	            <form action="adminUpdatePhoto.jsp" method="post">
	            	<input type="hidden" name="serviceId" value="<%= category.getId() %>">
	                <input type="hidden" name="action" value="upload">
	                
	                <button class="btn-upload" type="submit">Upload New Image</button>
	            </form>
	
	            <!-- Delete Button -->
	            <form action="adminDeleteService.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this service?');">
	                <input type="hidden" name="action" value="delete">
	                <input type="hidden" name="serviceId" value="<%= category.getId() %>">
	                <button class="btn-delete" type="submit">Delete</button>
	            </form>
	        </div>
	        <% 
	                }
	            } else {
	        %>
	        <p>No services available.</p>
	        <% 
	            }
	        %>
	        
	        <script>
	        
	        function storeServiceIdInCookie(serviceId){
	        	document.cookie = "serviceId="+serviceId+"; path=/;";
	        	
	        	document.getElementById('updateForm').onsubmit();
	        }
	        
	        </script>
	    </div>
</div>
</body>
</html>
