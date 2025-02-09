<%-- 
    JAD-CA2
    Class-DIT/FT/2A/23
    Student Name: Thiri Lae Win
    Admin No.: P2340739
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ page import="com.cleanerThirdParty.model.*" %>
    	<%@ page import="java.util.ArrayList"%>
    	
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: 'Arial', sans-serif;
    background-color: #f9f9f9;
    color: #333;
    padding: 20px;
}

header {
	margin-top: 8%;
    text-align: center;
    margin-bottom: 30px;
}

header h1 {
    font-size: 2.5em;
    margin-bottom: 10px;
}

header h3 {
    font-size: 1.2em;
    color: #555;
}

select {
    padding: 10px;
    font-size: 14px;
    margin-top: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    cursor: pointer;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background-color: white;
    border: 1px solid #ddd;
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.1);
}

thead {
    background-color: #6b4423;
    color: white;
}

th, td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

th {
    font-weight: bold;
}

tbody tr:hover {
    background-color: #f1f1f1;
}


tbody tr:nth-child(even) {
    background-color: #f9f9f9;
}

.error {
    color: red;
}

.message {
    color: green;
    text-align: center;
    margin-top: 15px;
}

button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 8px 16px;
    font-size: 14px;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.3s;
}

button:hover {
    background-color: #0056b3;
}


</style>
</head>
<body>
<h1>Bookings</h1>
<form action="<%=request.getContextPath()%>/GetBookingForThirdParty" method = "POST">
	<input type="hidden" name = "cleanerId" value="<%=request.getParameter("cleanerId")%>">
	<%System.out.print(request.getParameter("cleanerId") + "GetBookingForThirdParty"); %>
	
	<input type="submit" value="List All Bookings">
</form>

<form action="<%=request.getContextPath()%>/GetBookingById">
	<input type="hidden" name = "cleanerId" value="<%=request.getParameter("cleanerId")%>">
	<%System.out.print(request.getParameter("cleanerId") + "GetBookingById"); %>
	
	<input type="submit" value="Get Your Bookings">
</form>
    
<%
String error = (String)request.getAttribute("err");
if(error != null && error.equals("Not Found")){
	out.print("ERROR: Booking not found!");
}

@SuppressWarnings("unchecked")

ArrayList<Booking> uAL = (ArrayList<Booking>)request.getAttribute("bookingsByCleanerId");
%>


<table>
        <thead>
            <tr>
            	<th>#ID</th>
                <th>Customer Name</th>
                <th>Service Address</th>
                <th>Special Request</th>
                <th>Service</th>
                <th>Duration</th>             
                <th>Date</th>
                <th>Time</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <%-- Loop through all bookings and display them in table rows --%>
            <%
			if(uAL != null){
				for(Booking booking : uAL){
			        %>
			        <tr>
			        	<td><%=booking.getId() %></td>
			            <td><%= booking.getCustomerName() %></td>
			            <td><%= booking.getServiceAddress() %></td>
			            <td><%= booking.getSpecialRequest() %></td>               
			            <td><%= booking.getServiceName() %></td>
			            <td><%= booking.getDuration() %></td>            
			            <td><%= booking.getDate() %></td>
			            <td><%= booking.getTime() %></td>
			            <td>

						    <form action="<%= request.getContextPath() %>/UpdateStatusForThirdPartyServlet" method="POST">
						    	<input type="hidden" name = "cleanerId" value="<%=request.getParameter("cleanerId")%>">
						    	<input type="hidden" name = "bookingId" value="<%=booking.getId()%>">
						    
								<%System.out.print(request.getParameter("cleanerId") + "GetBookingById"); %>
						    	<select name="status" onchange="this.form.submit()">
						            <option value="Not Completed" <%= "Not Completed".equals(booking.getStatus()) ? "selected" : "" %>>Not Completed</option>
						            <option value="In Progress" <%= "In Progress".equals(booking.getStatus()) ? "selected" : "" %>>In Progress</option>
						            <option value="Completed" <%= "Completed".equals(booking.getStatus()) ? "selected" : "" %>>Completed</option>
						        </select>
						    </form>
						</td>
			        </tr>
			        <%
				}
			}
			%>
        </tbody>
    </table>
</body>
</html>