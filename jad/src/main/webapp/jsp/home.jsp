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
    // Determine the redirect URL based on user's login status
    String redirectURL;
    if (session != null && session.getAttribute("username") != null) {
        // If user is logged in, redirect to the services page
        redirectURL = "categories.jsp";
    } else {
        // If user is not logged in, redirect to the register page
        redirectURL = "register.jsp";
    }
    double averageRating = 0.0;
    int totalUsers = 0;
    
    List<Map<String, String>> reviews = new ArrayList<>();
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Get a database connection
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

        // Fetch the latest 3 feedbacks
        String feedbackSql = "SELECT comment, rating FROM feedback ORDER BY id DESC LIMIT 3";
        pstmt = conn.prepareStatement(feedbackSql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> review = new HashMap<>();
            review.put("comment", rs.getString("comment"));
            review.put("rating", String.valueOf(rs.getInt("rating")));
            reviews.add(review);
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
	        <button onclick="location.href='<%= redirectURL %>'" class="custom-btn">Book a Service</button>
	        
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
	
   <section class="testimonials-section">
    <div class="container">
        <h2 class="section-title">Hear What Our Customers Have to Say</h2>
        <p class="section-subtitle">
            Trusted by both local & expert communities, we are rated 
            <%= String.format("%.1f", averageRating) %>/5 stars on Google by over <%= totalUsers %>+ users!
        </p>
        <div class="row">
            <% if (reviews.isEmpty()) { %>
                <!-- Default Testimonials -->
                <div class="col-md-4 col-sm-6 col-12 mb-4">
                    <div class="testimonial-card">
                        <img src="/jad/gallery/verify.png" alt="Review Icon" class="review-icon">
                        <p class="testimonial-text">
                            “All pretty mummies need time for their hair and nails, right? I’m so happy that I found a part-time cleaner. She frees up so much of my weekends!”
                        </p>
                        <span class="customer-name">@midiforreal</span>
                        <div class="rating">★★★★★</div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-12 mb-4">
                    <div class="testimonial-card">
                        <img src="/jad/gallery/verify.png" alt="Review Icon" class="review-icon">
                        <p class="testimonial-text">
                            “I’ve worked with many helpers before. They go through training, so the quality is consistent. Highly recommend them!”
                        </p>
                        <span class="customer-name">@keweitay</span>
                        <div class="rating">★★★★★</div>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 col-12 mb-4">
                    <div class="testimonial-card">
                        <img src="/jad/gallery/verify.png" alt="Review Icon" class="review-icon">
                        <p class="testimonial-text">
                            “No housework means more time for work! My house is squeaky clean every week. So happy with the service!”
                        </p>
                        <span class="customer-name">@miss_luxe</span>
                        <div class="rating">★★★★★</div>
                    </div>
                </div>
            <% } else { 
                for (Map<String, String> review : reviews) { 
            %>
                <!-- Dynamic Testimonials -->
                <div class="col-md-4 col-sm-6 col-12 mb-4">
                    <div class="testimonial-card">
                        <img src="/jad/JAD-CA1/gallery/verify.png" alt="Review Icon" class="review-icon">
                        <p class="testimonial-text"><%= review.get("comments") %></p>
                        <div class="rating">
                            <% 
                                int rating = Integer.parseInt(review.get("rating"));
                                for (int i = 0; i < rating; i++) { 
                            %>
                                ★
                            <% } %>
                        </div>
                    </div>
                </div>
            <% 
                } 
            } 
            %>
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

</body>
</html>
