<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.cleaningService.dao.FeedbackDAO" %>
<%@ page import="com.cleaningService.model.Feedback" %>
<%@ page import="java.util.List" %>
	<%@ include file="authCheck.jsp" %>
	<%@ include file="../html/adminNavbar.html" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Feedback</title>
    <link rel="stylesheet" type="text/css" href="../css/adminRetrieveAllFeedback.css">

</head>
<body>
    <div class="container">
        <h2>Feedback Management</h2>
        <table class="feedback-table">
            <thead>
                <tr>
                    <th>Feedback ID</th>
                    <th>User Name</th>
                    <th>Feedback</th>
                    <th>Service</th>
                    <th>Rating</th>
                </tr>
            </thead>
            <tbody>
                <%
                    FeedbackDAO feedbackDAO = new FeedbackDAO();
                    List<Feedback> feedbackList = feedbackDAO.retrieveAllFeedbacks(); // Fetch feedback from DB
                    
                    if (feedbackList != null && !feedbackList.isEmpty()) {
                        for (Feedback feedback : feedbackList) {
                %>
                    <tr>
                        <td><%= feedback.getId()%></td>
                        <td><%= feedback.getUsername()%></td>
                        <td><%= feedback.getComments() %></td>
                        <td><%= feedback.getServiceName() %></td>
                        <td><%= feedback.getRating() %></td>
                       
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6">No feedback available.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>


</body>
</html>