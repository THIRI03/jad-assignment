
<%@ include file="authCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*" %>

<%
    List<Map<String, Object>> cart = (List<Map<String, Object>>) request.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Cart</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cart.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
    <script>
        function updateSummary() {
            const checkboxes = document.querySelectorAll('.cart-checkbox');
            const prices = document.querySelectorAll('.cart-price');
            const serviceCount = document.getElementById('serviceCount');
            const subtotalElement = document.getElementById('subtotal');
            const gstElement = document.getElementById('gst');
            const discountElement = document.getElementById('discount');
            const totalAmountElement = document.getElementById('totalAmount');

            let subtotal = 0;
            let selectedCount = 0;

            checkboxes.forEach((checkbox, index) => {
                if (checkbox.checked) {
                    const priceText = prices[index].textContent.trim().replace('$', '');
                    const priceValue = parseFloat(priceText);

                    if (!isNaN(priceValue)) {
                        subtotal += priceValue;
                        selectedCount++;
                    }
                }
            });

            const gst = subtotal * 0.07;
            const discount = subtotal * 0.10;
            const totalAmount = subtotal + gst - discount;

            serviceCount.innerText = selectedCount;
            subtotalElement.innerText = `$${subtotal.toFixed(2)}`;
            gstElement.innerText = `$${gst.toFixed(2)}`;
            discountElement.innerText = `$${discount.toFixed(2)}`;
            totalAmountElement.innerText = `$${totalAmount.toFixed(2)}`;
        }

        function removeFromCart(index) {
            fetch('<%= request.getContextPath() %>/CartServlet?remove=' + index, {
                method: 'GET',
                headers: { 'X-Requested-With': 'XMLHttpRequest' }
            })
            .then(response => response.text())
            .then(data => {
                document.querySelector('.cart-container').innerHTML = data;
                updateSummary();
            })
            .catch(error => console.error('Error:', error));
        }

        document.addEventListener('DOMContentLoaded', () => {
            updateSummary();
            const checkboxes = document.querySelectorAll('.cart-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('change', updateSummary);
            });
        });
    </script>
</head>
<body>
    <div class="cart-container">
        <h1 class="cart-header">My Cart</h1>
        <p class="service-info">You have selected <span id="serviceCount">0</span> service(s) for checkout.</p>

        <%
            if (cart.isEmpty()) {
        %>
                <p class="empty-cart">Your cart is empty.</p>
        <%
            } else {
                for (int i = 0; i < cart.size(); i++) {
                    Map<String, Object> item = cart.get(i);

                    String serviceName = (String) item.getOrDefault("serviceName", "Unavailable");
                    String imagePath = (String) item.getOrDefault("imagePath", "images/default-placeholder.png");
                    String price = item.getOrDefault("price", "0.00").toString();
                    String date = item.getOrDefault("date", "Not specified").toString();
                    String time = item.getOrDefault("time", "Not specified").toString();
                    String address = item.getOrDefault("serviceAddress", "Not specified").toString();
                    String specialRequest = item.getOrDefault("specialRequest", "NA").toString();
                    String duration = item.getOrDefault("duration", "1").toString();
        %>
        <div class="cart-item">
            <div class="cart-item-left">
                <input type="checkbox" name="selectedItems" value="<%= i %>" class="cart-checkbox" onchange="updateSummary()">
                <div class="cart-item-image">
                    <img src="<%= request.getContextPath() + "/" + imagePath %>" alt="<%= serviceName %>">
                </div>
            </div>
            <div class="cart-item-details">
                <h2><%= serviceName %></h2>
                <p class="cart-price">$<%= price %></p>
                <p>Date: <%= date %></p>
                <p>Time: <%= time %></p>
                <p>Duration: <%= duration %> hours</p>
                <p>Address: <%= address %></p>
                <p>Special Request: <%= specialRequest %></p>
            </div>
            <div class="cart-item-right">
                <button type="button" onclick="removeFromCart(<%= i %>)" class="remove-btn">Remove from Cart</button>
            </div>
        </div>
        <%
                }
            }
        %>

        <div class="cart-summary">
            <h3>Summary</h3>
            <p>Subtotal: <span id="subtotal">$0.00</span></p>
            <p>GST (7%): <span id="gst">$0.00</span></p>
            <p>Discount (10%): <span id="discount">$0.00</span></p>
            <p>Total Amount: <span id="totalAmount">$0.00</span></p>
        </div>
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
