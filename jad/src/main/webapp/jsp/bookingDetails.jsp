<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %>
<%@ include file="check.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="java.util.ArrayList, java.util.HashMap, java.util.Map, java.util.List" %>
<%@ page import="com.cleaningService.dao.BookingDAO" %>
<%@ page import="com.cleaningService.util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>Booking Details</title>
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/services.css">
    <link rel="stylesheet" href="../css/bookingDetails.css"> 
    <script>
        function showAlert(message) {
            alert(message);
        }
    </script>
</head>
<body>
    <div class="booking-container">
        <%
        String categoryId = request.getParameter("category_id");
        
        // User ID is already fetched in header.jsp, so no need to redeclare
        if (userId == null) {
            out.println("<p style='color:red;'>You need to log in to book a service.</p>");
            return;
        }

        // Fetch sub_service_id from the request
        String serviceId = request.getParameter("service_id");
        if (serviceId == null) {
            out.println("<p style='color:red;'>Error: Service ID is missing!</p>");
            return;
        }

        String serviceName = "";
        String description = "";
        String price = "";
        String image = "";

        String query = "SELECT * FROM service WHERE id = ?";
        try (Connection conn = com.cleaningService.util.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, Integer.parseInt(serviceId));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    serviceName = rs.getString("name");
                    description = rs.getString("description");
                    price = String.format("$%.2f", rs.getDouble("price"));
                    image = rs.getString("image");
                } else {
                    out.println("<p style='color:red;'>Service not found!</p>");
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>An error occurred while fetching service details.</p>");
            return;
        }
        %>

        <!-- Display Selected Service Details -->
        <div class="service-summary">
            <h1>Booking for: <%= serviceName %></h1>
            <p>Description: <%= description %></p>
            <p>Price: <%= price %></p>
            <img src="../<%= image %>" alt="<%= serviceName %>" class="service-image">
        </div>

        <!-- Booking Form -->
			<form method="post">
		        <input type="hidden" name="category_id" value="<%= categoryId %>">
                <input type="hidden" name="service_id" value="<%= serviceId %>">
		        
			    
			    <label for="date">Select Date:</label>
			    <input type="date" name="date" required>
			    
			    <label for="time">Select Time:</label>
			    <input type="time" name="time" required>
			    
			    <label for="duration">Duration (in hours):</label>
			    <input type="number" name="duration" min="1" required>
			    
			    <label for="serviceAddress">Service Address:</label>
			    <input type="text" name="serviceAddress" placeholder="Enter your address" required>
			    
			    <label for="specialRequest">Special Requests (optional):</label>
			    <textarea name="specialRequest" rows="4"></textarea>
			    
			    <div class="buttons-container">
			        <a href="services.jsp?category_id=<%= categoryId %>" class="btn back-btn">Back to Services</a>
			        <button type="submit" class="btn">Add to Cart</button>
			    </div>
			</form>

	
	<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String date = request.getParameter("date");
    String time = request.getParameter("time");
    String duration = request.getParameter("duration");
    String serviceAddress = request.getParameter("serviceAddress");
    String specialRequest = request.getParameter("specialRequest");

    // Create a booking map
    Map<String, Object> booking = new HashMap<>();
    booking.put("categoryId", serviceId);
    booking.put("serviceId", serviceId);
/*     booking.put("subServiceName", serviceName);
 */    booking.put("date", date);
    booking.put("time", time);
    booking.put("duration", duration);
    booking.put("serviceAddress", serviceAddress);
    booking.put("specialRequest", specialRequest);

    // Add to session cart
    ArrayList<Map<String, Object>> cart = (ArrayList<Map<String, Object>>) session.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }
    cart.add(booking);
    session.setAttribute("cart", cart);
    out.println("<script>showAlert('Service successfully added to the cart!');</script>");
    out.println("<p>Added to cart. <a href='cart.jsp?category_id=" + categoryId + "&service_id=" + serviceId + "' class='btn view-cart-btn'>View Cart</a></p>");
}
%>
	
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
