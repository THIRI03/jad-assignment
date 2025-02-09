<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JOJO Job Agency</title>
    <link rel="stylesheet" href="../css/home.css"> 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    
    
</head>
<body>
    
    <!-- Hero Section -->
	<section id="home" class="hero-section" style="background: #aec6cf;">
	    <div class="hero-overlay">
	<h1>Connecting You to Your Dream Job in Singapore</h1>
<p>Your trusted partner in building successful careers and finding top talent.</p>
	    </div>
	</section>
    

    <!-- Section 2: Leaders in Professional Cleaning -->
		<section class="leaders-section py-5">
    <div class="container">
        <!-- Left Column: Text and Button -->
        <div class="row align-items-center">
            <div class="col-md-6">
                <h2 class="mb-4">Leaders in Job Placement and Career Opportunities in Singapore</h2>
				<p class="mb-4 text-muted">
				    With years of experience, JOJO Job Agency has established itself as a trusted leader in connecting job seekers with the right opportunities across various industries in Singapore. 
				    We provide a full suite of employment services, including career counseling, job matching, and skill development. 
				    Our mission is to empower individuals by helping them achieve their career goals and support businesses by sourcing top talent.
				</p>
                
                 <a href="#contact-us" class="btn btn-outline-dark px-4 py-2">Contact Us</a>
            </div>
   
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
                    <p>enquiry@JOJOJobAgency.com<br>corporate@JOJOjobagency.com</p>
                </div>
            </div>
        </div>
    </div>
</section>
    
    

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
