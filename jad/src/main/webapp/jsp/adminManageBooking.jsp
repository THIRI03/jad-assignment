<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win, Moe Myat Thwe
    Admin No.: P2340739, P2340362
--%>

<%@ page language="java"
	contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.TreeSet"%>

<%@ page import="com.cleaningService.dao.BookingDAO"%>
<%@ page import="com.cleaningService.model.Booking"%>

<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">

	<title>Manage Bookings</title>

	<link rel="stylesheet"
		href="<%=request.getContextPath()%>/css/adminManageBooking.css?v=7">

	<!-- Used for pagination styling -->
	<link rel="stylesheet"
		href="<%=request.getContextPath()%>/css/adminTableTools.css?v=3">

	<!-- Font Awesome icons -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>

<body>

	<%@ include file="adminNavbar.jsp"%>

	<%
	BookingDAO bookingDAO = new BookingDAO();

	List<Booking> bookings =
			bookingDAO.retrieveAllBookings();

	/*
	 * TreeSet stores only unique values and sorts
	 * the filter choices alphabetically.
	 */
	Set<String> categories = new TreeSet<>();
	Set<String> addresses = new TreeSet<>();
	Set<String> statuses = new TreeSet<>();

	if (bookings != null) {

		for (Booking booking : bookings) {

			String category = booking.getCategoryName();

			if (category != null
					&& !category.trim().isEmpty()) {

				categories.add(category.trim());
			}

			String address = booking.getServiceAddress();

			if (address != null
					&& !address.trim().isEmpty()) {

				addresses.add(address.trim());
			}

			String status = booking.getStatus();

			if (status != null
					&& !status.trim().isEmpty()) {

				statuses.add(status.trim());
			}
		}
	}
	%>

	<main class="booking-page-content">

		<section class="page-heading">

			<h1>Manage Bookings</h1>

			<p>
				View and manage all customer bookings
			</p>

		</section>

		<section class="booking-section">

			<div class="section-heading">

				<div>

					<h2>All Bookings</h2>

					<p>
						Showing
						<span id="bookingResultCount">
							<%=bookings == null ? 0 : bookings.size()%>
						</span>
						booking(s)
					</p>

				</div>

			</div>

			<!-- Search and pagination -->
			<div class="table-tools">

				<div class="search-container">

					<span class="search-icon">
						<i class="fa-solid fa-magnifying-glass"></i>
					</span>

					<input
						type="search"
						id="bookingSearch"
						placeholder="Search customer, email, phone, service, address, status or date"
						autocomplete="off">

				</div>

				<div
					id="bookingPagination"
					class="pagination-container">
				</div>

			</div>

			<!-- Booking filter buttons -->
			<div class="booking-filter-bar">

				<!-- Category filter -->
				<div class="filter-dropdown">

					<button
						type="button"
						class="filter-dropdown-button"
						data-filter-target="categoryFilterMenu">

						<span>Category</span>

						<i class="fa-solid fa-chevron-down"></i>

					</button>

					<div
						id="categoryFilterMenu"
						class="filter-dropdown-menu">

						<p class="filter-dropdown-title">
							Select categories
						</p>

						<div id="categoryFilter">

							<%
							if (!categories.isEmpty()) {

								for (String category : categories) {
							%>

							<label class="filter-checkbox">

								<input
									type="checkbox"
									value="<%=category%>">

								<span><%=category%></span>

							</label>

							<%
								}

							} else {
							%>

							<p class="no-filter-option">
								No categories available
							</p>

							<%
							}
							%>

						</div>

					</div>

				</div>

				<!-- Status filter -->
				<div class="filter-dropdown">

					<button
						type="button"
						class="filter-dropdown-button"
						data-filter-target="statusFilterMenu">

						<span>Status</span>

						<i class="fa-solid fa-chevron-down"></i>

					</button>

					<div
						id="statusFilterMenu"
						class="filter-dropdown-menu">

						<p class="filter-dropdown-title">
							Select statuses
						</p>

						<div id="statusFilter">

							<%
							if (!statuses.isEmpty()) {

								for (String status : statuses) {
							%>

							<label class="filter-checkbox">

								<input
									type="checkbox"
									value="<%=status%>">

								<span><%=status%></span>

							</label>

							<%
								}

							} else {
							%>

							<p class="no-filter-option">
								No statuses available
							</p>

							<%
							}
							%>

						</div>

					</div>

				</div>

				<!-- Location filter -->
				<div class="filter-dropdown">

					<button
						type="button"
						class="filter-dropdown-button"
						data-filter-target="addressFilterMenu">

						<span>Location</span>

						<i class="fa-solid fa-chevron-down"></i>

					</button>

					<div
						id="addressFilterMenu"
						class="filter-dropdown-menu">

						<p class="filter-dropdown-title">
							Select service addresses
						</p>

						<div id="addressFilter">

							<%
							if (!addresses.isEmpty()) {

								for (String address : addresses) {
							%>

							<label class="filter-checkbox">

								<input
									type="checkbox"
									value="<%=address%>">

								<span><%=address%></span>

							</label>

							<%
								}

							} else {
							%>

							<p class="no-filter-option">
								No locations available
							</p>

							<%
							}
							%>

						</div>

					</div>

				</div>

				<!-- Booking date filter -->
				<div class="filter-dropdown">

					<button
						type="button"
						class="filter-dropdown-button"
						data-filter-target="dateFilterMenu">

						<span>Booking Date</span>

						<i class="fa-solid fa-chevron-down"></i>

					</button>

					<div
						id="dateFilterMenu"
						class="filter-dropdown-menu date-filter-menu">

						<p class="filter-dropdown-title">
							Select date range
						</p>

						<div class="date-filter-group">

							<label for="dateFromFilter">
								From
							</label>

							<input
								type="date"
								id="dateFromFilter">

						</div>

						<div class="date-filter-group">

							<label for="dateToFilter">
								To
							</label>

							<input
								type="date"
								id="dateToFilter">

						</div>

					</div>

				</div>

				<!-- Clear filters -->
				<button
					type="button"
					id="resetBookingFilters"
					class="reset-filter-button">

					<i class="fa-solid fa-rotate-left"></i>

					Clear Filters

				</button>

			</div>

			<div class="table-container">

				<table>

					<thead>

						<tr>
							<th>Booking ID</th>
							<th>Customer Name</th>
							<th>Customer Email</th>
							<th>Phone Number</th>
							<th>Service</th>
							<th>Category</th>
							<th>Service Address</th>
							<th>Date</th>
							<th>Time</th>
							<th>Duration</th>
							<th>Special Request</th>
							<th>Status</th>
							<th>Total Price</th>
						</tr>

					</thead>

					<tbody id="bookingTableBody">

						<%
						if (bookings != null
								&& !bookings.isEmpty()) {

							for (Booking booking : bookings) {

								String specialRequest =
										booking.getSpecialRequest();

								boolean noSpecialRequest =
										specialRequest == null
										|| specialRequest.trim().isEmpty()
										|| specialRequest.equalsIgnoreCase("NA")
										|| specialRequest.equalsIgnoreCase("NIL");

								String statusClass =
										"status-default";

								if ("Completed".equalsIgnoreCase(
										booking.getStatus())) {

									statusClass =
											"status-completed";

								} else if ("In Progress".equalsIgnoreCase(
										booking.getStatus())) {

									statusClass =
											"status-progress";

								} else if ("Not Completed".equalsIgnoreCase(
										booking.getStatus())) {

									statusClass =
											"status-not-completed";
								}

								String categoryValue =
										booking.getCategoryName() == null
										? ""
										: booking.getCategoryName().trim();

								String addressValue =
										booking.getServiceAddress() == null
										? ""
										: booking.getServiceAddress().trim();

								String statusValue =
										booking.getStatus() == null
										? ""
										: booking.getStatus().trim();

								String dateValue =
										booking.getDate() == null
										? ""
										: booking.getDate().trim();
						%>

						<tr
							data-category="<%=categoryValue%>"
							data-address="<%=addressValue%>"
							data-status="<%=statusValue%>"
							data-date="<%=dateValue%>">

							<td>
								<%=booking.getId()%>
							</td>

							<td>
								<%=booking.getCustomerName()%>
							</td>

							<td>

								<%
								String customerEmail =
										booking.getCustomerEmail();

								if (customerEmail == null
										|| customerEmail.trim().isEmpty()) {
								%>

								<span class="muted-text">
									No email
								</span>

								<%
								} else {
								%>

								<a
									class="customer-email"
									href="mailto:<%=customerEmail%>">

									<%=customerEmail%>

								</a>

								<%
								}
								%>

							</td>

							<td>

								<%
								String customerPhone =
										booking.getCustomerPhone();

								if (customerPhone == null
										|| customerPhone.trim().isEmpty()) {
								%>

								<span class="muted-text">
									No phone number
								</span>

								<%
								} else {
								%>

								<%=customerPhone%>

								<%
								}
								%>

							</td>

							<td>
								<%=booking.getServiceName()%>
							</td>

							<td>
								<%=booking.getCategoryName()%>
							</td>

							<td>
								<%=booking.getServiceAddress()%>
							</td>

							<td>
								<%=booking.getDate()%>
							</td>

							<td>
								<%=booking.getTime()%>
							</td>

							<td>
								<%=booking.getDuration()%> hour(s)
							</td>

							<td class="special-request">

								<%
								if (noSpecialRequest) {
								%>

								<span class="muted-text">
									No special request
								</span>

								<%
								} else {
								%>

								<%=specialRequest%>

								<%
								}
								%>

							</td>

							<td>

								<span class="status <%=statusClass%>">
									<%=booking.getStatus()%>
								</span>

							</td>

							<td>
								$<%=String.format(
										"%.2f",
										booking.getTotalPrice())%>
							</td>

						</tr>

						<%
							}

						} else {
						%>

						<tr class="empty-row">

							<td
								colspan="13"
								class="empty-message">

								No bookings available.

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

	<!-- Booking page uses its own JavaScript file -->
	<script
		src="<%=request.getContextPath()%>/javaScript/adminBookingFilter.js?v=5">
	</script>

</body>
</html>