<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.cleaningService.dao.FeedbackDAO" %>
<%@ page import="com.cleaningService.model.Feedback" %>
<%@ page import="java.util.List" %>
<%@ include file="/jsp/adminNavbar.jsp" %>
<%@ include file="authCheck.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Feedback</title>
<link rel="stylesheet" type="text/css" href="../jad/css/adminRetrieveAllFeedback.css">
<link rel="stylesheet" type="text/css" href="../jad/css/adminNavbar.css">
</head>
<body>
    <div class="container">
        <h2>Feedback Management</h2>
        
        <form action="<%=request.getContextPath() %>/AdminSortFeedbackServlet" method="GET">
            <label for="ratingFilter">Sort by Rating:</label>
            <select id="ratingFilter" name="rating" >
        		<option value="All Ratings" <%= (request.getParameter("rating") == null || request.getParameter("rating").isEmpty()) ? "selected" : "" %>>All Ratings</option>
                <option value="1" <%= "1".equals(request.getParameter("rating")) ? "selected" : "" %>>1</option>
                <option value="2" <%= "2".equals(request.getParameter("rating")) ? "selected" : "" %>>2</option>
                <option value="3" <%= "3".equals(request.getParameter("rating")) ? "selected" : "" %>>3</option>
                <option value="4" <%= "4".equals(request.getParameter("rating")) ? "selected" : "" %>>4</option>
                <option value="5" <%= "5".equals(request.getParameter("rating")) ? "selected" : "" %>>5</option>
            </select>
            <button type="submit">Apply</button>
        </form>
        
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
                    List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
                    
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