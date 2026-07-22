<%--  
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win, Moe Myat Thwe
    Admin No.: P2340739, P2340362
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.cleaningService.model.User"%>
<%@ page import="com.cleaningService.dao.UserDAO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Users</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/adminRetrieveMember.css?v=3">

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/adminTableTools.css?v=2">

<!-- Font Awesome icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>

	<%@ include file="adminNavbar.jsp"%>

	<%
	UserDAO userDAO = new UserDAO();
	List<User> users = userDAO.retrieveAllUsers();
	%>

	<main class="main-content">

		<div class="users-section">

			<h2>View and manage registered users</h2>

			<!-- Search and pagination -->
			<div class="table-tools">

				<div class="search-container">

					<span class="search-icon"> <i
						class="fa-solid fa-magnifying-glass"></i>
					</span> <input type="search" id="userSearch"
						placeholder="Search by ID, name, email, phone, address or role"
						autocomplete="off">

				</div>

				<div id="userPagination" class="pagination-container"></div>

			</div>

			<div class="table-container">

				<table>
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Address</th>
							<th>Role</th>
							<th>Action</th>
						</tr>
					</thead>

					<tbody id="userTableBody">

						<%
						if (users != null && !users.isEmpty()) {

							for (User user : users) {
						%>

						<tr
							data-search="<%=user.getId() + " " + user.getName() + " " + user.getEmail() + " " + user.getPhoneNum() + " "
		+ user.getAddress() + " " + user.getRoleId()%>">

							<td><%=user.getId()%></td>
							<td><%=user.getName()%></td>
							<td><%=user.getEmail()%></td>
							<td><%=user.getPhoneNum()%></td>
							<td><%=user.getAddress()%></td>
							<td><%=user.getRoleId()%></td>

							<td>
								<form action="adminUpdateMember.jsp" method="get">

									<input type="hidden" name="userId" value="<%=user.getId()%>">

									<button class="btn-update" type="submit">Update</button>

								</form>
							</td>

						</tr>

						<%
						}
						} else {
						%>

						<tr class="empty-row">
							<td colspan="7" class="empty-message">No users found.</td>
						</tr>

						<%
						}
						%>

					</tbody>
				</table>

			</div>

		</div>

	</main>

	<script
		src="<%=request.getContextPath()%>/javaScript/adminTableTools.js?v=2">
		
	</script>

	<script>
		setupTableTools({
			tableBodySelector : "#userTableBody",
			searchInputSelector : "#userSearch",
			paginationSelector : "#userPagination",
			rowsPerPage : 10,
			columnCount : 7,
			noResultsMessage : "No matching users found."
		});
	</script>

</body>
</html>