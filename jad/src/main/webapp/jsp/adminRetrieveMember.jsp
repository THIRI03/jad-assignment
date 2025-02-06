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
<%@ include file="/jsp/adminNavbar.jsp" %>
<link rel="stylesheet" href="../css/adminRetrieveMember.css">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <title>All Users</title>
</head>
<body>
	<title>All Users</title>
</head>
<body>

<div class="main-content">
  <h1>All Users</h1>
  <form action="">
  	<select>
  		
  	</select>
  </form>
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Phone</th>
        <th>Address</th>
        <th>Role</th>
        <th></th>
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
         <form action="adminUpdateUserInformation.jsp" method="POST">
         	<input type="hidden" name="userId" value="<%= user.getId() %>">
         	<button class="btn-update">Edit</button>
		</form>
		
		<form action="<%=request.getContextPath()%>/DeleteUserForAdmin" method="POST">
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