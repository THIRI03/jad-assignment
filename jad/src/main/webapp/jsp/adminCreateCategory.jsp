<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.cleaningService.util.DBConnection" %>
<%@ page import="com.cleaningService.dao.CategoryDAO" %>
<%@ page import="com.cleaningService.model.Category" %>
<%@ include file="authCheck.jsp" %>
<%@ include file="../html/adminNavbar.html" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Category</title>
    <style>
        /* Basic CSS to create a card layout */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            width: 400px;
            text-align: center;
        }

        h2 {
            color: #333;
            font-size: 24px;
        }

        label {
            font-size: 16px;
            color: #555;
            margin-bottom: 10px;
            display: block;
            text-align: left;
            width: 100%;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box; /* Ensures padding is included in the width */
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 100%; /* Make the submit button span the full width */
            box-sizing: border-box; /* Ensures padding is included in the width */
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .message {
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }

        .error {
            color: red;
        }

        .success {
            color: green;
        }
    </style>
</head>
<body>

    <div class="card">
        <h2>Create New Category</h2>

        <!-- Form for creating a new category -->
        <form method="POST">
            <label for="categoryName">Category Name:</label>
            <input type="text" id="categoryName" name="categoryName" required>
            <br><br>
            <input type="submit" value="Create Category">
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    String categoryName = request.getParameter("categoryName");
                    CategoryDAO categoryDAO = new CategoryDAO();
                    boolean isCreated = categoryDAO.createCategory(categoryName);

                    if (isCreated) {
                        out.println("<p class='message success'>Category created successfully!</p>");
                        %>
                        
                        <%
                    } else {
                        out.println("<p class='message error'>Failed to create category. Please try again.</p>");
                        out.println("<p><a href='adminRetrieveAllCategorie.jsp'>Go back to All Categories</a></p>");

                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p class='message error'>Error occurred while creating the category.</p>");
                }
            }
        %>

    </div>

</body>
</html>
