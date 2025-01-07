<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "com.cleaningService.model.Category" %> 
<%@ page import = "com.cleaningService.dao.CategoryDAO" %>
<%@ include file="authCheck.jsp" %>
<%@ include file="../html/adminNavbar.html" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Category</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f9;
    }
    .container {
        max-width: 800px;
        margin: 50px auto;
        padding: 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .card {
        padding: 20px;
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 6px;
        background: #f9f9f9;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .card input[type="text"] {
        width: 70%;
        padding: 10px;
        margin-right: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .card button {
        padding: 10px 15px;
        background-color: #007bff;
        border: none;
        color: #fff;
        border-radius: 4px;
        cursor: pointer;
    }
    .card button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>Update Categories</h2>
        <%
        String categoryIdStr = request.getParameter("categoryId");

        if(categoryIdStr == null){
        	%><script>
        	alert('categoryId not found.')
        	return;
        	</script>
        	<%
        }else{
        	int categoryId = Integer.parseInt(categoryIdStr);
        
            // Fetch all categories from the database
            CategoryDAO categoryDAO = new CategoryDAO();
            Category ctg = new Category();
            ctg = categoryDAO.retrieveCategoryById(categoryId);

            if (ctg != null) {
        %>
        <div class="card">
            <form method="post">
                <input type="hidden" name="categoryId" value="<%= ctg.getId() %>">
                <input type="text" name="categoryName" value="<%= ctg.getCategoryName()%>" required>
                <button type="submit">Update</button>
            </form>
        </div>
        <%               
            } else {
        %>
        <p>No categories found.</p>
        <%
            }
            
            if("POST".equalsIgnoreCase(request.getMethod())){
            	try{
            		String categoryName = request.getParameter("categoryName");
            		Category categoryToUpdate = new Category();
            		categoryToUpdate.setId(categoryId);
            		categoryToUpdate.setCategoryName(categoryName);
            		boolean isUpdate = categoryDAO.updateCategory(categoryToUpdate);
            		
            		if(isUpdate){
            			%>
            			<script>alert('Category name updated successfully.')</script>
            			<%
            			response.sendRedirect("adminRetrieveAllCategory.jsp");

            		}else{
            			%>
            			<script>alert('Failed to update category name.')</script>
            			<%
            		}
            	}catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error occurred while creating the category.</p>");
                }
            }
            }
        %>
    </div>
</body>
</html>
