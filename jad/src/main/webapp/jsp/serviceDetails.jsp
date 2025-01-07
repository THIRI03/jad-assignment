<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="header.jsp" %>
<link rel="stylesheet" href="../css/services.css">
<link rel="stylesheet" href="../css/home.css">

<%
String serviceId = request.getParameter("service_id");

    String sql = "SELECT ss.sub_service_id, ss.sub_service_name, ss.description, ss.price, ss.image " +
                 "FROM sub_service ss " +
                 "WHERE ss.service_id = ?";

    List<Map<String, String>> subServices = new ArrayList<>();

    try (Connection conn = com.cleaningService.util.DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, Integer.parseInt(serviceId));
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Map<String, String> subService = new HashMap<>();
                subService.put("id", rs.getString("sub_service_id")); 
                subService.put("name", rs.getString("sub_service_name"));
                subService.put("description", rs.getString("description"));
                subService.put("price", String.format("%.2f", rs.getDouble("price")));
                subService.put("image", rs.getString("image"));
                subServices.add(subService);
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
        <% for (Map<String, String> subService : subServices) { %>
            <div class="sub-service-card">
                <img src="../<%= subService.get("image") %>" alt="<%= subService.get("name") %>">
                <h2><%= subService.get("name") %></h2>
                <p><%= subService.get("description") %></p>
                <p>Price: $<%= subService.get("price") %></p>
                <!-- Use the sub_service_id here -->
              <a href="bookingDetails.jsp?service_id=<%=serviceId %>&sub_service_id=<%= subService.get("id") %>" class="btn-book-now">Book Now</a>
              
               
            </div>
        <% } %>
    </div>
    <div class="back-to-services">
        <a href="services.jsp">
            <span class="back-arrow">&larr;</span> Back to Services
        </a>
    </div>
</section>

    <jsp:include page="../html/footer.html" />
