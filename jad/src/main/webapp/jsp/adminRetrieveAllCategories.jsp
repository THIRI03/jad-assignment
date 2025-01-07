
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
<%@ include file="authCheck.jsp" %>
<%@ include file="../html/adminNavbar.html" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>All Categories</title>
  <style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }

    .main-content {
        padding: 20px;
        margin-top: 60px;
    }

    .create-btn {
    	margin-top: 60px;
        position: absolute;
        top: 20px;
        right: 20px;
        padding: 10px 20px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .create-btn:hover {
        background-color: #218838;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 60px;
    }

    table th, table td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
    }

    table th {
        background-color: #f4f4f4;
        font-weight: bold;
    }

    table tbody tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    table tbody tr:hover {
        background-color: #f1f1f1;
    }

    .btn-update {
        background-color: #007bff;
    }

    .btn-delete {
        background-color: #dc3545;
    }

    .btn-update:hover {
        background-color: #0056b3;
    }

    .btn-delete:hover {
        background-color: #c82333;
    }
  </style>
</head>
<body>
<div class="main-content">
  <!-- Create New Category button -->
  <button class="create-btn" onclick="location.href='adminCreateCategory.jsp'">Create New Category</button>

  <h1>All Categories</h1>
  <table>
    <thead>
      <tr>
        <th>Category Name</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <% 
        HttpSession userSession = request.getSession();
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAllCategory();
        
        if (categories != null && !categories.isEmpty()) {
          for (Category category : categories) {
      %>
      <tr>
        <td><%= category.getCategoryName() %></td> <!-- Display category name -->
        <td>
          <!-- Update Button -->
          <button class="btn-update" onclick="location.href='adminUpdateCategory.jsp?categoryId=<%= category.getId() %>'">Update</button>
          <!-- Delete Button -->
          <button class="btn-delete" onclick="if(confirm('Are you sure you want to delete this category?')) location.href='adminDeleteCategory.jsp?categoryId=<%= category.getId() %>'">Delete</button>
        </td>
      </tr>
      <% 
          }
        } else {
      %>
      <tr>
        <td colspan="2">No categories found.</td> 
      </tr>
      <% 
        }
      %>
    </tbody>
  </table>
</div>
</body>
</html>
