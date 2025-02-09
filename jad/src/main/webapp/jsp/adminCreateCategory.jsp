<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.cleaningService.util.DBConnection" %>
<%@ page import="com.cleaningService.dao.CategoryDAO" %>
<%@ page import="com.cleaningService.model.Category" %>
<%-- <%@ include file="authCheck.jsp" %> --%>
<%@ include file="/jsp/adminNavbar.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Category</title>
  		<link rel="stylesheet" href="../../jad/css/adminCreateCategory.css">
  		
</head>
<body>

    <div class="card">
        <h2>Create New Category</h2>
        <form action="<%=request.getContextPath()%>/CreateCategoryForAdminServlet" method="POST" enctype="multipart/form-data">
            <label for="name">Category Name:</label>
            <input type="text" id="categoryName" name="name" required>
            <br><br>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>
            <br><br>

            <label for="image">Upload Image:</label>
            <input type="file" id="image" name="image" accept="image/*" required>
            <br><br>

            <input type="submit" value="Create Category">
        </form>
    </div>

</body>
</html>
