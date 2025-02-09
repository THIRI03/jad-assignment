<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import = "com.cleaningService.model.Service" %> 
<%@ page import = "com.cleaningService.dao.ServiceDAO" %> 
<%@ page import = "jakarta.servlet.http.HttpSession" %>
<%-- <%@ include file="authCheck.jsp" %>--%>
<%@ include file="/jsp/adminNavbar.jsp" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/adminRetrieveServices.css">
</head>
<body>
    <div class="main-content">	    
    <h1>All Services</h1>
    
    	<!-- Search Bar -->
	    <div class="search-reset-container">
    <div class="left-container">
        <form action="<%= request.getContextPath() %>/SearchServiceNameForAdminServlet" method="get" class="search-form">
 	      <input type="text" name="userInput" placeholder="Search by service name..." value="<%= request.getParameter("userInput") != null ? request.getParameter("userInput") : "" %>">
            
            <button type="submit" class="search-btn">Search</button>
        </form>
        <form action="<%= request.getContextPath() %>/jsp/adminRetrieveServices.jsp" method="get" class="reset-form">
            <button type="submit" class="reset-btn">Reset</button>
        </form>
    </div>

    <div class="right-container">
        <form action="<%= request.getContextPath() %>/FilterServicesForAdminServlet" method="get" class="filter-form">
            <select name="filter" class="filter-select" onchange="this.form.submit()">
                <option value="All" <%="All".equals(request.getParameter("filter")) ? "selected": "" %>>All</option>
                <option value="top3Rated" <%="top3Rated".equals(request.getParameter("filter")) ? "selected": "" %>>Top 3 Best Rated</option>
                <option value="least3Rated" <%="least3Rated".equals(request.getParameter("filter")) ? "selected": "" %>>Least 3 Rated</option>
                <option value="top3InDemand" <%="top3InDemand".equals(request.getParameter("filter")) ? "selected": "" %>>Top 3 in Demand</option>
                <option value="least3InDemand" <%="least3InDemand".equals(request.getParameter("filter")) ? "selected": "" %>>Least 3 in Demand</option>
            </select>
        </form>
        <form action="<%=request.getContextPath() %>/jsp/adminCreateService.jsp">
            <button type="submit" class="btn-create">Create New Service</button>
        </form>
    </div>
</div>


    
	    <div class="card-container">
	    
	     <%  
            ServiceDAO serviceDAO = new ServiceDAO();
            String userInput = request.getParameter("userInput");
            String filter = request.getParameter("filter");
            List<Service> services = new ArrayList<>();

            if (userInput != null && !userInput.trim().isEmpty()) {
                services = (List<Service>) request.getAttribute("servicesAfterSearch");
            }else if(filter != null && !filter.trim().isEmpty()){
            	services = (List<Service>) request.getAttribute("filteredServices");
            } else{
                services = serviceDAO.retrieveService();
            }
                        	
            if (services != null && !services.isEmpty()) {
                for (Service service : services) {
	                
	        %>
	        <div class="card">
	            <img src="<%= request.getContextPath() %>/<%= service.getImage() %>" alt="Service Image">
	            <h3><%= service.getName() %></h3>
	            <p><strong>Price:</strong> $<%= service.getPrice() %></p>
	            <p><strong>Description:</strong> <%= service.getDescription() %></p>
	
	            <!-- Update Button -->
	            <form action="/jsp/adminUpdateService.jsp" method="get">
				    <input type="hidden" name="serviceId" value="<%= service.getId() %>">
				    <input type="hidden" name="action" value="update">
				    <button class="btn-update" type="submit">Update</button>
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