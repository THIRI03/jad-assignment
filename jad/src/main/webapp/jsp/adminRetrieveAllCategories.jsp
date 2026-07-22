<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.cleaningService.model.Category"%>
<%@ page import="com.cleaningService.dao.CategoryDAO"%>

<%@ include file="authCheck.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>All Categories</title>

	<link rel="stylesheet"
		href="<%=request.getContextPath()%>/css/adminRetrieveAllCategories.css?v=1">
		
</head>

<body>

	<%@ include file="adminNavbar.jsp"%>

	<%
	CategoryDAO categoryDAO = new CategoryDAO();
	List<Category> categories = categoryDAO.getAllCategory();
	%>

	<main class="main-content">

		<section class="categories-section">

			<div class="section-header">

				<div>
					<h2>All Categories</h2>
					<p>View and manage all cleaning service categories.</p>
				</div>

				<button class="create-btn"
					onclick="location.href='adminCreateCategory.jsp'">
					Create New Category
				</button>

			</div>

			<div class="table-container">

				<table>
					<thead>
						<tr>
							<th>Category Name</th>
							<th>Actions</th>
						</tr>
					</thead>

					<tbody>

						<%
						if (categories != null && !categories.isEmpty()) {
							for (Category category : categories) {
						%>

						<tr>
							<td><%=category.getCategoryName()%></td>

							<td class="action-cell">

								<button class="btn-update"
									onclick="location.href='adminUpdateCategory.jsp?categoryId=<%=category.getId()%>'">
									Update
								</button>

								<button class="btn-delete"
									onclick="if (confirm('Are you sure you want to delete this category?')) location.href='adminDeleteCategory.jsp?categoryId=<%=category.getId()%>'">
									Delete
								</button>

							</td>
						</tr>

						<%
							}
						} else {
						%>

						<tr>
							<td colspan="2" class="empty-message">
								No categories found.
							</td>
						</tr>

						<%
						}
						%>

					</tbody>
				</table>

			</div>

		</section>

	</main>

</body>
</html>