<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/services.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/jsp/header.jsp">
<%@ include file="authCheck.jsp" %>


<%
//Retrieve the category ID from the request
String categoryId = request.getParameter("category_id");

//SQL query to fetch services based on the category ID
    String sql = "SELECT s.id, s.name, s.description, s.price, s.image " +
                 "FROM service s " +
    			 "JOIN category c ON s.category_id = c.id "+
                 "WHERE c.id = ?";

    List<Map<String, String>> services = new ArrayList<>();

    try (Connection conn = com.cleaningService.util.DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, Integer.parseInt(categoryId));
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, String> service = new HashMap<>();
                service.put("id", rs.getString("id")); 
                service.put("name", rs.getString("name"));
                service.put("description", rs.getString("description"));
                service.put("price", String.format("%.2f", rs.getDouble("price")));
                service.put("image", rs.getString("image"));
                services.add(service);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<section class="service-details">
    <div class="title-container">
        <h1>Service Details</h1>
    </div>
    <div class="sub-services-container">
        <% for (Map<String, String> service : services) { %>
            <div class="sub-service-card">
               <img src="<%= request.getContextPath() + "/" + service.get("image").replace('\\', '/') %>" alt="<%= service.get("name") %>">
                <h2><%= service.get("name") %></h2>
                <p><%= service.get("description") %></p>
                <p>Price: $<%= service.get("price") %></p>
                <!-- Use the service_id here -->
             <a href="<%= request.getContextPath() %>/jsp/bookingDetails.jsp?category_id=<%= categoryId %>&service_id=<%= service.get("id") %>" 
   class="btn-book-now">Book Now</a>         
               
            </div>
        <% } %>
    </div>

</section>

    <jsp:include page="../html/footer.html" />
 
  