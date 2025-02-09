<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "com.cleaningService.model.Category" %> 
<%@ page import = "com.cleaningService.dao.CategoryDAO" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Category</title>
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/adminUpdateCategory.css">

<body>
<h1>Update Category</h1>

    <%
    String message = request.getParameter("message");
    if(message != null){
    	%>
    	<script>alert("<%=message%>");</script>
    	<%
    }
    %>

  

<%
    // Retrieve serviceId from the URL parameter
    String categoryIdStr = request.getParameter("categoryId");
	int categoryId = 0;
    if(categoryIdStr != null){
        categoryId = Integer.parseInt(categoryIdStr);
    }else{
    	categoryId = (int) request.getAttribute("categoryId");
    }
    // Fetch the service details from the database using serviceId
    CategoryDAO categoryDAO = new CategoryDAO();
    Category category = categoryDAO.retrieveCategoryById(categoryId);
	System.out.print(category.getId());

%>
	<form action="<%=request.getContextPath() %>/UpdateCategoryServletForAdmin" method="post" enctype="multipart/form-data">
	    <input type="hidden" name="categoryId" value="<%= category.getId() %>"> 
	    <div class="form-group">
	        <label for="name">Category Name:</label>
	        <input type="text" id="name" name="name" value="<%= category.getCategoryName() %>" required>
	    </div>
	
	    <div class="form-group">
	        <label for="description">Description:</label>
	        <textarea id="description" name="description" required><%= category.getDescription() %></textarea>
	    </div>
	
	    <div class="form-group">
	        <% String imagePath = category.getImage(); 
        
	        if (imagePath != null && !imagePath.isEmpty()) { %>
	            <div>
	                <img src="<%= request.getContextPath() %>/<%= imagePath %>" alt="Current Image" width="100" />
	            </div>
	        <% } %>
        
        <!-- File input to allow the user to upload a new image -->
        <input type="file" id="image" name="image"><br><br>

	    </div>
	
	    <div class="form-group">
	        <button type="submit">Update Category</button>
	    </div>
	    <button type="submit">
		    <a href="/jad/jsp/adminRetrieveAllCategories.jsp" class="btn-back" style="text-decoration: none;">Back to Categories</a>
		</button>

	</form>
</body>
</html>
