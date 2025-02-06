<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "com.cleaningService.model.Service" %> 
<%@ page import = "com.cleaningService.dao.ServiceDAO" %> 
<%@ page import = "jakarta.servlet.http.HttpSession" %>
<%-- <%@ include file="authCheck.jsp" %>
 --%><%@ include file="/jsp/adminNavbar.jsp" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/adminRetrieveServices.css">
</head>
<body>
    <div clas="main-content">	    
    <h3>All Services</h3>
	    <div class="card-container">
	        <%  
	            ServiceDAO serviceDAO = new ServiceDAO();
	            // Retrieve the list of services from the database
	            List<Service> services = serviceDAO.retrieveService();
	            
	            if (services != null && !services.isEmpty()) {
	                for (Service service : services) {
	        %>
	        <div class="card">
	            <img src="<%= request.getContextPath() %>/<%= service.getImage() %>" alt="Service Image">
	            <h3><%= service.getName() %></h3>
	            <p><strong>Price:</strong> $<%= service.getPrice() %></p>
	            <p><strong>Description:</strong> <%= service.getDescription() %></p>
	
	            <!-- Update Button -->
	            <form action="adminUpdateService.jsp" method="get">
				    <input type="hidden" name="serviceId" value="<%= service.getId() %>">
				    <input type="hidden" name="action" value="update">
				    <button class="btn-update" type="submit">Update</button>
			</form>

	            
	            <!-- Upload New Image Button -->
	            <form action="adminUpdatePhoto.jsp" method="post">
	            	<input type="hidden" name="serviceId" value="<%= service.getId() %>">
	                <input type="hidden" name="action" value="upload">
	                
	                <button class="btn-upload" type="submit">Upload New Image</button>
	            </form>
	
	            <!-- Delete Button -->
	            <form action="adminDeleteService.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this service?');">
	                <input type="hidden" name="action" value="delete">
	                <input type="hidden" name="serviceId" value="<%= service.getId() %>">
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