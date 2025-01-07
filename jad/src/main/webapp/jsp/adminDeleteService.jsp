

<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@ page import = "com.cleaningService.dao.ServiceDAO" %>
       <%@ include file="authCheck.jsp" %>
        <%@ include file="../html/adminNavbar.html" %>
        

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String serviceIdStr = request.getParameter("serviceId");

    
    if (serviceIdStr != null) {
    	int serviceId = Integer.parseInt(serviceIdStr);
        try {
            ServiceDAO serviceDAO = new ServiceDAO();
            boolean isDeleted = serviceDAO.deleteService(serviceId);

            if (isDeleted) {
                out.println("<p>Service deleted successfully.</p>");
                // Redirect or display success message
                response.sendRedirect("adminRetrieveServices.jsp"); // Redirect to a list page
            } else {
                out.println("<p>Failed to delete service. Please try again.</p>");
            }
        } catch (NumberFormatException e) {
            out.println("<p>Invalid service ID format. Please try again.</p>");
        }
    } else {
        out.println("<p>Service ID is missing. Please provide a valid service ID.</p>");
    }
%>
</body>
</html>