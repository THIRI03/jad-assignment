<%-- 
    JAD-CA2
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
<%-- <%@ include file="authCheck.jsp" %>--%>
<%@ include file="/jsp/adminNavbar.jsp" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Service</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/adminUpdateService.css">
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
<form method="post" action="<%=request.getContextPath() %>/UpdateServiceServletForAdmin" enctype="multipart/form-data">
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
        <!-- Service Image -->
        <label for="serviceImage">Service Image:</label>
        
        <!-- If the service has an image, display it -->
        <% String imagePath = service.getImage(); %>
        <% 
        if (imagePath != null && !imagePath.isEmpty()) { %>
            <div>
                <img src="<%= request.getContextPath() %>/<%= imagePath %>" alt="Current Image" width="100" />
            </div>
        <% } %>
        
        <!-- File input to allow the user to upload a new image -->
        <input type="file" id="serviceImage" name="serviceImage"><br><br>


    <button type="submit" value="Update Service">Update Service</button>
    <a href="adminRetrieveServices.jsp">Go back to the service list</a>
    
</form>

</div>

</body>
</html>
