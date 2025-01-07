<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %>
<%@ include file="check.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*, java.sql.*, com.cleaningService.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../css/cart.css">
    <script>
 
        function updateSummary() {
            const checkboxes = document.querySelectorAll('.cart-checkbox');
            const prices = document.querySelectorAll('.cart-price');
            const serviceCount = document.getElementById('serviceCount');
            const subtotalElement = document.getElementById('subtotal');

            let subtotal = 0;
            let selectedCount = 0;

            checkboxes.forEach((checkbox, index) => {
                if (checkbox.checked) {
                	const priceText = prices[index]?.innerText || "$0.00";
                    subtotal += parseFloat(prices[index].innerText.replace('$', ''));
                    selectedCount++;
                }
            });

            serviceCount.innerText = selectedCount;
            subtotalElement.innerText = `$${subtotal.toFixed(2)}`;
        }
  

        function validateCheckout(event) {
            const checkboxes = document.querySelectorAll('.cart-checkbox');
            const isAnySelected = Array.from(checkboxes).some(checkbox => checkbox.checked);

            if (!isAnySelected) {
                event.preventDefault();
                alert('Please select at least one service to proceed to checkout.');
            }
        }
    </script>
</head>
<body>
    <div class="cart-container">
        <h1 class="cart-header">My Cart</h1>
        <p class="service-info">You have selected <span id="serviceCount">0</span> service(s) for checkout.</p>
        <form action="/jad/CartCheckoutServlet" method="post">
            <%
            String serviceIdParam = request.getParameter("service_id");
            String subServiceIdParam = request.getParameter("sub_service_id");
                List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

                if (cart == null || cart.isEmpty()) {
            %>
                <p class="empty-cart">Your cart is empty.</p>
            <%
                } else {
                    for (int i = 0; i < cart.size(); i++) {
                        Map<String, Object> item = cart.get(i);

                        int subServiceId = Integer.parseInt(item.get("subServiceId").toString());
                        String subServiceName = "";
                        String image = "";
                        double price = 0.0;

                        try (Connection conn = DBConnection.getConnection();
                             PreparedStatement stmt = conn.prepareStatement(
                                 "SELECT sub_service_name, image, price FROM sub_service WHERE sub_service_id = ?")) {
                            stmt.setInt(1, subServiceId);
                            try (ResultSet rs = stmt.executeQuery()) {
                                if (rs.next()) {
                                    subServiceName = rs.getString("sub_service_name");
                                    image = rs.getString("image");
                                    price = rs.getDouble("price");
                                }
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }

                        String date = (String) item.getOrDefault("date", "Not specified");
                        String time = (String) item.getOrDefault("time", "Not specified");
                        String address = (String) item.getOrDefault("serviceAddress", "Not specified");
                        String specialRequest = (String) item.getOrDefault("specialRequest", "NA");
                        int duration = Integer.parseInt(item.getOrDefault("duration", "1").toString());
            %>
            <div class="cart-item">
                <div class="cart-item-left">
                    <input type="checkbox" name="selectedItems" value="<%= i %>" class="cart-checkbox" onchange="updateSummary()">
                    <div class="cart-item-image">
                        <img src="../<%= image %>" alt="<%= subServiceName %>">
                    </div>
                </div>
                <div class="cart-item-details">
                    <h2><%= subServiceName %></h2>
                    <p class="cart-price">$<%= String.format("%.2f", price) %></p>
                    <p>Date: <%= date %></p>
                    <p>Time: <%= time %></p>
                    <p>Duration: <%= duration %> hours</p>
                    <p>Address: <%= address %></p>
                    <p>Special Request: <%= specialRequest %></p>
                </div>
                <div class="cart-item-right">
                    <button type="submit" name="remove" value="<%= i %>" class="remove-btn">Remove from Cart</button>
                </div>
            </div>
            <%
                    }
                }
            %>
            <div class="cart-summary">
               
                <button type="submit" name="checkout" class="checkout-btn" value="true" onclick="validateCheckout(event)">Checkout</button>
            </div>
        </form>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', updateSummary);
    </script>
    <jsp:include page="../html/footer.html" />
</body>
</html>
