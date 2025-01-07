<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %> 
<%@ page import="java.sql.*, java.util.*" %>
<link rel="stylesheet" href="../css/services.css">
<link rel="stylesheet" href="../css/home.css">

<%
// SQL query to fetch all services
    String sql = "SELECT s.service_id, s.service_name, s.description, s.price, s.image, c.category_name " +
                 "FROM service s " +
                 "JOIN service_category c ON s.category_id = c.category_id";

    List<Map<String, String>> services = new ArrayList<>(); // This is for top-level services

    try (Connection conn = com.cleaningService.util.DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Map<String, String> service = new HashMap<>();
            service.put("id", rs.getString("service_id"));
            service.put("name", rs.getString("service_name"));
            service.put("description", rs.getString("description"));
            service.put("price", String.format("%.2f", rs.getDouble("price")));
            service.put("image", rs.getString("image"));
            service.put("category", rs.getString("category_name"));
            services.add(service);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<section class="services">
    <div class="title-container">
        <h1>Service Categories</h1>
    </div>
    
    <div class="services-container">
        <% for (Map<String, String> service : services) { %>
            <div class="service-card">
                <img src="<%=request.getContextPath() + service.get("image") %>" alt="<%= service.get("name") %>">
                <h2><%= service.get("name") %></h2>
                <p><%= service.get("description") %></p>
                <a href="serviceDetails.jsp?service_id=<%= service.get("id") %>" class="btn btn-primary">More Info</a>
            </div>
        <% } %>
    </div>
</section>

    <jsp:include page="../html/footer.html" />
