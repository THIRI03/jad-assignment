<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ page import="java.util.List" %>
	<%@ page import="com.cleaningService.model.User" %>
	<%@ page import="com.cleaningService.dao.UserDAO" %>
<%-- 	<%@ include file="authCheck.jsp" %> --%>
	<%@ include file="../html/adminNavbar.html" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>All Users</title>
</head>
<body>



  <title>All Users</title>
  <style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }

    .main-content {
        padding: 20px;
        margin-top: 60px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
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
        background-color: #6b4423;
    }


    .btn-update:hover {
        background-color: #343a40;
    }


  </style>
</head>
<body>

<div class="main-content">
  <h1>All Users</h1>
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
        <th>Role</th>
        <th>Update</th>
      </tr>
    </thead>
    <tbody>
      <%
        // Retrieve all users
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.retrieveAllUsers();
        
        if (users != null && !users.isEmpty()) {
          for (User user : users) {
      %>
      <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getName() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getPhoneNum() %></td>
        <td><%= user.getAddress() %></td>
        <td><%= user.getRoleId() %></td>
        <td>
          <!-- Update Button -->
          <button class="btn-update">Update</button>
        </td>
      </tr>
      <% 
          }
        } else {
      %>
      <tr>
        <td colspan="7">No users found.</td>
      </tr>
      <% 
        }
      %>
    </tbody>
  </table>
</div>


</body>
</html>