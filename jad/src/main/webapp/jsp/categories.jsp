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
// SQL query to fetch all categories
    String sql = "SELECT * FROM category";

    List<Map<String, String>> categories = new ArrayList<>(); // This is for top-level services

    try (Connection conn = com.cleaningService.util.DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Map<String, String> category = new HashMap<>();
            category.put("id", rs.getString("id"));
            category.put("name", rs.getString("name"));
            category.put("description", rs.getString("description"));
/*             category.put("price", String.format("%.2f", rs.getDouble("price")));
 */            category.put("image", rs.getString("image"));
/*             category.put("category", rs.getString("category_name"));
 */            categories.add(category);
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
        <% for (Map<String, String> category : categories) { %>
            <div class="service-card">
                <img src="<%=request.getContextPath() + category.get("image") %>" alt="<%= category.get("name") %>">
                <h2><%= category.get("name") %></h2>
                <p><%= category.get("description") %></p>
                <a href="services.jsp?category_id=<%= category.get("id") %>" class="btn btn-primary">More Info</a>
            </div>
        <% } %>
    </div>
</section>

    <jsp:include page="../html/footer.html" />
