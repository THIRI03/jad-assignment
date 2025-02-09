<%@ page import="java.sql.*, java.util.*" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/services.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
<%@ include file="header.jsp" %>

<%
    // Retrieve the category ID from the request
    String categoryId = request.getParameter("category_id");

    // SQL query to fetch services based on the category ID
    String sql = "SELECT s.id, s.name, s.description, s.price, s.image " +
                 "FROM service s " +
                 "JOIN category c ON s.category_id = c.id " +
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

<section class="service-details" style="background-color: #e6f7ff; padding: 20px;">
    <div class="title-container">
        <h1 style="text-align: center; color: #004d80;">Service Details</h1>
    </div>
    <div class="sub-services-container" style="display: flex; flex-wrap: wrap; justify-content: center; gap: 20px;">
        <% if (services.isEmpty()) { %>
            <p style="text-align: center; color: #004d66;">No services available for this category.</p>
        <% } else { 
            for (Map<String, String> service : services) { %>
                <div class="sub-service-card" style="background-color: #f0fbff; border: 1px solid #cceeff; padding: 15px; border-radius: 8px; text-align: center; width: 250px;">
                    <img src="<%= request.getContextPath() + "/" + service.get("image").replace('\\', '/') %>" alt="<%= service.get("name") %>" style="max-width: 100%; height: auto; border-radius: 8px;">
                    <h2 style="color: #005580; margin: 10px 0;"><%= service.get("name") %></h2>
                    <p style="color: #004d66;"><%= service.get("description") %></p>
                    <p style="color: #004d66;">Price: $<%= service.get("price") %></p>
                </div>
        <%  } } %>
    </div>
    <div class="back-to-services" style="text-align: center; margin-top: 20px;">
        <a href="<%= request.getContextPath() %>/ThirdParty_GetAllCategoriesServlet" style="color: #0077b3; font-weight: bold; text-decoration: none;">
            <span class="back-arrow">&larr;</span> Back to Services
        </a>
    </div>
</section>

<jsp:include page="../html/footer.html" />
