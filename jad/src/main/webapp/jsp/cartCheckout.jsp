<%@ include file="header.jsp" %>
<%@ include file="authCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Checkout Summary</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cart.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
  <style>
    .checkout-container {
        width: 60%;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff8e1;
        border: 1px solid #e6d4b8;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .checkout-header {
        text-align: center;
        color: #6b4423;
        font-size: 2rem;
        margin-bottom: 20px;
    }

    .checkout-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px;
        margin-bottom: 15px;
        border: 1px solid #e6d4b8;
        border-radius: 8px;
        background-color: #fffefb;
        color: #5c4033;
    }

    .checkout-item-left img {
        width: 150px;
        height: 150px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #dcdcdc;
    }

    .checkout-item-details {
        flex-grow: 1;
        padding: 0 15px;
    }

    .checkout-summary {
        margin-top: 30px;
        padding: 15px;
        border: 1px solid #e6d4b8;
        background-color: #fffefb;
        border-radius: 8px;
        font-size: 1.2rem;
        color: #5c4033;
    }

    .confirm-btn {
        display: block;
        margin: 30px auto;
        background-color: #337ab7;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 1.1rem;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
        width: fit-content;
    }

    .confirm-btn:hover {
        background-color: #286090;
    }
</style>
    
</head>
<body>
    <div class="checkout-container">
        <h1 class="checkout-header">Checkout Summary</h1>

        <%
            List<Map<String, Object>> selectedCartItems = (List<Map<String, Object>>) session.getAttribute("selectedCartItems");
            double subtotal = 0.0;

            if (selectedCartItems != null && !selectedCartItems.isEmpty()) {
                for (Map<String, Object> item : selectedCartItems) {
                    String serviceName = (String) item.get("serviceName");
                    String imagePath = (String) item.getOrDefault("imagePath", "images/default-placeholder.png");
                    String date = (String) item.get("date");
                    String time = (String) item.get("time");
                    String duration = item.get("duration").toString();
                    String address = (String) item.get("serviceAddress");
                    String specialRequest = (String) item.get("specialRequest");
                    double price = Double.parseDouble(item.get("price").toString().replace("$", ""));
                    subtotal += price;
        %>
        <!-- Item details section -->
        <div class="checkout-item">
            <div class="checkout-item-left">
                <img src="<%= request.getContextPath() %>/<%= imagePath %>" alt="<%= serviceName %>">
            </div>
            <div class="checkout-item-details">
                <h2><%= serviceName %></h2>
                <p>Price: $<%= String.format("%.2f", price) %></p>
                <p>Date: <%= date %></p>
                <p>Time: <%= time %></p>
                <p>Duration: <%= duration %> hours</p>
                <p>Address: <%= address %></p>
                <p>Special Request: <%= specialRequest %></p>
            </div>
        </div>
        <% 
                }
            } else {
        %>
        <p class="empty-cart">No items selected for checkout.</p>
        <% } %>

        <!-- Summary and Confirm Checkout button -->
        <div class="checkout-summary">
            <h3>Invoice Summary</h3>
            <p>Subtotal: $<%= String.format("%.2f", subtotal) %></p>
            <p>GST (7%): $<%= String.format("%.2f", subtotal * 0.07) %></p>
            <p>Discount (10%): $<%= String.format("%.2f", subtotal * 0.10) %></p>
            <p>Total Amount: $<%= String.format("%.2f", subtotal + (subtotal * 0.07) - (subtotal * 0.10)) %></p>
        </div>
        <form action="<%= request.getContextPath() %>/ConfirmCheckoutServlet" method="POST">
            <button type="submit" class="confirm-btn">Confirm Checkout</button>
        </form>
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
