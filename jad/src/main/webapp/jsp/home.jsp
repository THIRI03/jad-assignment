<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap" %>
<%@ page import="com.cleaningService.util.DBConnection" %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<%
    String redirectURL;
    if (session != null && session.getAttribute("username") != null) {
        redirectURL = "categories.jsp";
    } else {
        redirectURL = "register.jsp";
    }

    List<Map<String, String>> reviews = new ArrayList<>();
    List<Map<String, String>> topServices = new ArrayList<>();
    List<Map<String, String>> lowServices = new ArrayList<>();
    double averageRating = 0.0;
    int totalUsers = 0;

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DBConnection.getConnection();

        // Fetch average rating and total feedback count
        String avgSql = "SELECT AVG(rating) AS average_rating, COUNT(*) AS total_users FROM feedback";
        pstmt = conn.prepareStatement(avgSql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            averageRating = rs.getDouble("average_rating");
            totalUsers = rs.getInt("total_users");
        }
        rs.close();
        pstmt.close();

        // Fetch the latest 3 feedbacks with 4 or 5-star ratings
        String feedbackSql = "SELECT comment, rating FROM feedback WHERE rating >= 4 AND comment IS NOT NULL ORDER BY id DESC LIMIT 3";
        pstmt = conn.prepareStatement(feedbackSql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, String> review = new HashMap<>();
            review.put("comment", rs.getString("comment"));
            review.put("rating", String.valueOf(rs.getInt("rating")));
            reviews.add(review);
        }
        rs.close();
        pstmt.close();

        // Query for top services
        String topServicesSql = "SELECT s.name AS service_name, s.image AS image_path, COUNT(b.id) AS booking_count " +
                                "FROM service s LEFT JOIN bookings b ON s.id = b.serviceid " +
                                "GROUP BY s.id, s.name, s.image " +
                                "ORDER BY booking_count DESC LIMIT 3";
        pstmt = conn.prepareStatement(topServicesSql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, String> service = new HashMap<>();
            service.put("name", rs.getString("service_name"));
            service.put("count", String.valueOf(rs.getInt("booking_count")));
            service.put("imagePath", rs.getString("image_path"));
            topServices.add(service);
        }
        rs.close();
        pstmt.close();

        // Fetch bottom 3 services by booking count
        String lowServicesSql = "SELECT s.name AS service_name, s.image AS image_path, COUNT(b.id) AS booking_count " +
                                "FROM service s LEFT JOIN bookings b ON s.id = b.serviceid " +
                                "GROUP BY s.id, s.name, s.image " +
                                "ORDER BY booking_count ASC LIMIT 3";
        pstmt = conn.prepareStatement(lowServicesSql);
        rs = pstmt.executeQuery();
        while (rs.next()) {
            Map<String, String> service = new HashMap<>();
            service.put("name", rs.getString("service_name"));
            service.put("count", String.valueOf(rs.getInt("booking_count")));
            service.put("imagePath", rs.getString("image_path"));
            lowServices.add(service);
        }
    } catch (Exception e) {
        out.println("An error occurred while fetching data: " + e.getMessage());
        e.printStackTrace(new java.io.PrintWriter(out));
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shiny Home Services</title>
    <link rel="stylesheet" href="../css/home.css"> 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    
    
</head>
<body>
   
    <!-- Welcome Section -->
    <section class="welcome-section">
        <h1>
            <% if (session.getAttribute("username") != null) { %>
                Welcome, <%= session.getAttribute("username") %>!
            <% } else { %>
                Welcome to Shiny Home Services!
            <% } %>
        </h1>
    </section>
    
    <!-- Hero Section -->
	<section id="home" class="hero-section" style="background: url('/jad/gallery/home.jpg') no-repeat center center/cover;">
	    <div class="hero-overlay">
	        <h1>Professional Cleaning Services at Your Doorstep</h1>
	        <p>Your trusted partner for a cleaner, healthier environment.</p>
	        <button onclick="location.href='<%= request.getContextPath() %>/CategoryServlet?fetch=true'" class="custom-btn">Book a Service</button>
	        
	    </div>
	</section>
    

    <!-- Section 2: Leaders in Professional Cleaning -->
		<section class="leaders-section py-5">
    <div class="container">
        <!-- Left Column: Text and Button -->
        <div class="row align-items-center">
            <div class="col-md-6">
                <h2 class="mb-4">Leaders in Professional Cleaning Services in Singapore</h2>
                <p class="mb-4 text-muted">
                    Shiny’s years of experience have positioned us as the leaders in professional cleaning services in Singapore. 
                    We encompass a full range of deep cleaning and sanitation solutions for residential and corporate spaces. 
                    Our singular aim is to enhance your environment to a superior state of cleanliness and hygiene.
                </p>
                 <a href="#contact-us" class="btn btn-outline-dark px-4 py-2">Contact Us</a>
            </div>
            
			 <div class="col-md-6">
                <div class="service-highlights d-flex">
                    <!-- Highlight 1 -->
                    <div class="highlight">
                        <img src="../gallery/spray_img1.jpg" alt="Safety Icon">
                        <h4>Safety of Cleaning Agents</h4>
                    </div>
                    <!-- Highlight 2 -->
                    <div class="highlight">
                        <img src="../gallery/clean_home1.png" alt="Cleaning Icon">
                        <h4>An Extraordinary Cleaning Operation</h4>
                    </div>
                </div>
            </div>
   
</div>
    </div>
</section>
	
   <!-- Section: Testimonials -->
    <section class="testimonials-section">
        <div class="container">
            <h2 class="section-title">Hear What Our Customers Have to Say</h2>
            <p class="section-subtitle">
                Trusted by both local & expert communities, we are rated 
                <%= String.format("%.1f", averageRating) %>/5 stars on Google by over <%= totalUsers %>+ users!
            </p>
            <div class="row">
                <%
                    int reviewCount = reviews.size();
                    // Add the dynamic reviews first
                    for (int i = 0; i < reviewCount; i++) {
                        Map<String, String> review = reviews.get(i);
                %>
                        <div class="col-md-4 col-sm-6 col-12 mb-4">
                            <div class="testimonial-card">
                                <img src="<%= request.getContextPath() %>/gallery/verify.png" alt="Review Icon" class="review-icon">
                                <p class="testimonial-text"><%= review.get("comment") %></p>
                                <div class="rating">
                                    <% 
                                        int rating = Integer.parseInt(review.get("rating"));
                                        for (int j = 0; j < rating; j++) { 
                                    %>
                                        ★
                                    <% } %>
                                </div>
                            </div>
                        </div>
                <% 
                    }
                    
                    // If there are fewer than 3 dynamic reviews, fill the rest with default reviews
                    for (int i = reviewCount; i < 3; i++) {
                %>
                        <div class="col-md-4 col-sm-6 col-12 mb-4">
                            <div class="testimonial-card">
                                <img src="<%= request.getContextPath() %>/gallery/verify.png" alt="Review Icon" class="review-icon">
                                <p class="testimonial-text">
                                    “This cleaning service has exceeded my expectations! Highly professional and reliable.”
                                </p>
                
                                <div class="rating">★★★★★</div>
                            </div>
                        </div>
                <% } %>
            </div>
        </div>
    </section>
   
 <!-- Top and Bottom Services Section -->
<section class="services-carousel-section">
    <div class="container">
        <!-- Top Services -->
        <h2 class="section-title mt-5 text-center">Top 3 High-Demand Services</h2>
        <div id="topServicesCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <% 
                    int index = 0;
                    for (Map<String, String> service : topServices) { 
                        String activeClass = (index == 0) ? "active" : "";
                        String imagePath = service.get("imagePath");
                %>
                    <div class="carousel-item <%= activeClass %>">
                        <div class="carousel-content text-center" style="padding: 30px;">
                            <h3 style="font-size: 1.6rem; margin-bottom: 15px;"><%= service.get("name") %></h3>
                            <p style="font-size: 1.1rem; margin-bottom: 20px;">Number of Bookings: <%= service.get("count") %></p>
                            <img src="<%= request.getContextPath() %>/<%= imagePath %>" alt="Service Image" 
                                 style="max-width: 90%; height: 350px; object-fit: cover; border-radius: 12px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
                        </div>
                    </div>
                <% 
                        index++;
                    } 
                %>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#topServicesCarousel" data-bs-slide="prev"
                    style="background-color: rgba(0, 0, 0, 0.5); border-radius: 50%; width: 50px; height: 50px;">
                <span class="carousel-control-prev-icon" style="filter: invert(1);" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#topServicesCarousel" data-bs-slide="next"
                    style="background-color: rgba(0, 0, 0, 0.5); border-radius: 50%; width: 50px; height: 50px;">
                <span class="carousel-control-next-icon" style="filter: invert(1);" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <!-- Low Services -->
        <h2 class="section-title mt-5 text-center">Top 3 Low-Demand Services</h2>
        <div id="lowServicesCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <% 
                    index = 0;
                    for (Map<String, String> service : lowServices) { 
                        String activeClass = (index == 0) ? "active" : "";
                        String imagePath = service.get("imagePath");
                %>
                    <div class="carousel-item <%= activeClass %>">
                        <div class="carousel-content text-center" style="padding: 30px;">
                            <h3 style="font-size: 1.6rem; margin-bottom: 15px;"><%= service.get("name") %></h3>
                            <p style="font-size: 1.1rem; margin-bottom: 20px;">Number of Bookings: <%= service.get("count") %></p>
                            <img src="<%= request.getContextPath() %>/<%= imagePath %>" alt="Service Image" 
                                 style="max-width: 90%; height: 350px; object-fit: cover; border-radius: 12px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
                        </div>
                    </div>
                <% 
                        index++;
                    } 
                %>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#lowServicesCarousel" data-bs-slide="prev"
                    style="background-color: rgba(0, 0, 0, 0.5); border-radius: 50%; width: 50px; height: 50px;">
                <span class="carousel-control-prev-icon" style="filter: invert(1);" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#lowServicesCarousel" data-bs-slide="next"
                    style="background-color: rgba(0, 0, 0, 0.5); border-radius: 50%; width: 50px; height: 50px;">
                <span class="carousel-control-next-icon" style="filter: invert(1);" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>
</section>
 
 
    
<!-- Section 4: Benefits for Your Organization -->
<section class="benefits-section">
    <div class="container">
        <h2 class="section-title">The Benefits for Your Organization</h2>
        <div class="benefit-cards">
            <!-- Benefit Card 1 -->
            <div class="benefit-card">
                <img src="/jad/gallery/efficiency.png" alt="Efficiency Icon" class="benefit-icon">
                <h3>Increased Efficiency</h3>
                <p>Automating the booking process removes manual coordination and saves time.</p>
            </div>
            <!-- Benefit Card 2 -->
            <div class="benefit-card">
                <img src="/jad/
gallery/betterService.png" alt="Service Icon" class="benefit-icon">
                <h3>Better Service</h3>
                <p>Instant appointment booking eliminates back-and-forth communication hassles.</p>
            </div>
            <!-- Benefit Card 3 -->
            <div class="benefit-card">
                <img src="/jad/gallery/reminder.png" alt="reminder Icon" class="benefit-icon">
                <h3>Decreased No-shows</h3>
                <p>Automatic reminders ensure appointments are not forgotten or missed.</p>
            </div>
        </div>
    </div>
</section>

    <!-- Section 5: Contact Us -->
    <section id="contact-us" class="contact-section">
    <div class="container">
        <h2 class="section-title">Contact Us</h2>
        <div class="contact-details">
            <!-- Address -->
            <div class="contact-item">
                <i class="fas fa-map-marker-alt contact-icon"></i>
                <div>
                    <h3>Address</h3>
                    <p>5 Yishun Industrial Street 1<br>#01-24 Northspring BizHub</p>
                </div>
            </div>
            <!-- Operating Hours -->
            <div class="contact-item">
                <i class="fas fa-clock contact-icon"></i>
                <div>
                    <h3>Operating Hours</h3>
                    <p>Weekdays: 9am - 6pm<br>Saturday: 9am - 6pm</p>
                </div>
            </div>
            <!-- Phone -->
            <div class="contact-item">
                <i class="fas fa-phone contact-icon"></i>
                <div>
                    <h3>Phone</h3>
                    <p>+65 6602 8171</p>
                </div>
            </div>
            <!-- Email -->
            <div class="contact-item">
                <i class="fas fa-envelope contact-icon"></i>
                <div>
                    <h3>Email</h3>
                    <p>enquiry@shiny.com<br>corporate@shiny.com</p>
                </div>
            </div>
        </div>
    </div>
</section>
    
    

    <!-- Footer -->
    <jsp:include page="../html/footer.html" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
