<%@ page contentType="text/html;charset=UTF-8" language="java" %>
	<%@ page import="com.cleaningService.dao.UserDAO" %>
	<%@ page import="com.cleaningService.model.User" %>
<%@ include file="authCheck.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User Information</title>
    <!-- Add Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <%
    String message = (String)request.getAttribute("message");
    if(message != null){
    	%>
    	<script>alert("<%=message%>");</script>
    	<%
    }
    %>

  

	<%
	UserDAO userDAO = new UserDAO();
	User user = new User();
    String idStr = request.getParameter("userId");
    int id = Integer.parseInt(idStr);
	
    user = userDAO.retrieveUserById(id);
	%>
    <div class="container mt-5">
        <h2>Update User Information</h2>
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation">
                <a class="nav-link active" id="updateInfo-tab" data-toggle="tab" href="#updateInfo" role="tab" aria-controls="updateInfo" aria-selected="true">Update Information</a>
            </li>
            <li class="nav-item" role="presentation">
                <a class="nav-link" id="updatePassword-tab" data-toggle="tab" href="#updatePassword" role="tab" aria-controls="updatePassword" aria-selected="false">Update Password</a>
            </li>
        </ul>
        <div class="tab-content" id="myTabContent">
            <!-- Update Information Tab -->
            <div class="tab-pane fade show active" id="updateInfo" role="tabpanel" aria-labelledby="updateInfo-tab">
            
            <!-- Use of updating information servlet-->
                <form action="<%=request.getContextPath()%>/UpdateUserInfoForAdminServlet"method="POST">
        	        <input type="hidden" id="user_id" name="user_id" value="<%= id %>">
                
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" class="form-control" id="username" name="username" value="<%= user.getName() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%= user.getEmail() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="phone" class="form-control" id="phone" name="phone" value="<%= user.getPhoneNum() %>" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Update Info</button>
                </form>
            </div>

            <!-- Update Password Tab -->
            <div class="tab-pane fade" id="updatePassword" role="tabpanel" aria-labelledby="updatePassword-tab">
                <form action="<%=request.getContextPath()%>/UpdateUserPasswordForAdminServlet" method="POST">
          	        <input type="hidden" id="user_id" name="user_id" value="<%= id %>">
                
                    <div class="form-group">
                        <label for="currentPassword">Current Password</label>
                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="newPassword">New Password</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword">Confirm New Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                   	
                    <button type="submit" class="btn btn-primary">Update Password</button>
                </form>
            </div>
        </div>

        <!-- Back Button -->
        <a href="/jad/jsp/adminRetrieveMember.jsp" class="btn btn-secondary mt-3">Back</a>
    </div>

    <!-- Add Bootstrap JS and jQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
