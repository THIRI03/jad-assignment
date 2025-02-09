<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.cleaningService.model.User" %>
<%@ page import="com.cleaningService.dao.UserDAO" %>
<%@ include file="/jsp/adminNavbar.jsp" %>
<%@ include file="authCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>All Users</title>
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/adminRetrieveMember.css">
</head>
<body>

<div class="main-content">
  <h1>All Users</h1>
    <div class="left-container">
    
    <%
    String message = request.getParameter("message");
    if(message != null){
    	%>
    	<script>alert(<%=message%>);</script>
    	<%
    }
    %>

  <!-- Search Bar and Filter Dropdown -->
  <form action="<%=request.getContextPath() %>/SearchUserByNameForAdminServlet" method="POST">
    <input type="text" name="searchName" placeholder="Search by name" value="<%= request.getParameter("searchName") != null ? request.getParameter("searchName") : "" %>">
    <button type = "submit"> Search </button>
  </form>
  
          <form action="<%= request.getContextPath() %>/jsp/adminRetrieveMember.jsp" method="get" class="reset-form">
            <button type="submit" class="reset-btn">Reset</button>
        </form>
</div>
    
        <div class="right-container">
    
  <form action = "<%=request.getContextPath() %>/FilterUserBySpendingAndDemand" method = "POST">
    <select name="filterOption">
      <option value="">Select Filter</option>
      <option value="top10Spending" <%= "top10Spending".equals(request.getParameter("filterOption")) ? "selected" : "" %>>Top 10 Most Spending</option>
      <option value="least10Inactive" <%= "least10Inactive".equals(request.getParameter("filterOption")) ? "selected" : "" %>>Least 10 Inactive Customers</option>
    </select>
    
    <button type="submit">Apply</button>
    
    
  </form>
  
  		<form action="<%=request.getContextPath() %>/jsp/adminCreateNewUser.jsp">
            <button type="submit" class="btn-create">Create New User</button>
        </form>
  </div>
  
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
        <th>Total Spent</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <%
        // Retrieve users based on search or filter
        UserDAO userDAO = new UserDAO();
        String searchName = request.getParameter("searchName");
        String filterOption = request.getParameter("filterOption");
        List<User> users;

        if (request.getParameter("filterOption") != null) {
            users = (List<User>) request.getAttribute("userList");
        } else if (request.getParameter("searchName")!=null) {
            users = (List<User>) request.getAttribute("users");
        } else {
            users = userDAO.retrieveAllUsers();
        }
        

        if (users != null && !users.isEmpty()) {
          for (User user : users) {
      %>
      <tr>
        <td><%= user.getId() %></td>
        <td><%= user.getName() %></td>
        <td><%= user.getEmail() %></td>
        <td><%= user.getPhoneNum() %></td>
        <td><%= user.getAddress() %></td>
        <td><%= user.getTotalSpent() %></td>
        <td>
          <!-- Update Button -->
          <form action="adminUpdateUserInformation.jsp" method="POST" style="display:inline-block;">
            <input type="hidden" name="userId" value="<%= user.getId() %>">
            <button class="btn-update">Edit</button>
          </form>

          <form action="<%= request.getContextPath() %>/DeleteUserForAdmin" method="POST" style="display:inline-block;">
            <input type="hidden" name="userId" value="<%= user.getId() %>">
            <button class="btn-delete">Delete</button>
          </form>
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
