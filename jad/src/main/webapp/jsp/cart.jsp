<%@ include file="header.jsp" %>
<%@ include file="authCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Cart</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cart.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
    <script>
 // Function to remove an item from the cart using AJAX
    function removeFromCart(index) {
    fetch('<%= request.getContextPath() %>/CartServlet?remove=' + index, {
        method: 'GET',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
    })
    .then(response => response.text())
    .then(data => {
        // Update the cart content without refreshing the page
        document.querySelector('.cart-container').innerHTML = data;
    })
    .catch(error => console.error('Error:', error));
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
        <form action="<%= request.getContextPath() %>/CartCheckoutServlet" method="POST" onsubmit="validateCheckout(event)">
            <%
                List<Map<String, Object>> cart = (List<Map<String, Object>>) request.getAttribute("cart");
                if (cart == null || cart.isEmpty()) {
            %>
                <p class="empty-cart">Your cart is empty.</p>
            <%
                } else {
                    for (int i = 0; i < cart.size(); i++) {
                        Map<String, Object> item = cart.get(i);
                     // Ensure serviceId and categoryId are present in each item
                        String serviceId = item.get("serviceId").toString();  
                        String categoryId = item.get("categoryId").toString();
                        
                        String serviceName = (String) item.getOrDefault("serviceName", "Unavailable");
                        String imagePath = (String) item.getOrDefault("imagePath", "images/default-placeholder.png");
                        String price = item.getOrDefault("price", "0.00").toString();
                        String date = item.getOrDefault("date", "N/A").toString();
                        String time = item.getOrDefault("time", "N/A").toString();
                        String address = item.getOrDefault("serviceAddress", "N/A").toString();
                        String specialRequest = item.getOrDefault("specialRequest", "N/A").toString();
            %>
            <div class="cart-item">
                <div class="cart-item-left">
                    <input type="checkbox" name="selectedItems" value="<%= i %>" class="cart-checkbox">
                    <input type="hidden" name="serviceId" value="<%= item.get("serviceId") %>">
                    <input type="hidden" name="categoryId" value="<%= categoryId %>">
                    <div class="cart-item-image">
                        <img src="<%= request.getContextPath() + "/" + imagePath %>" alt="<%= serviceName %>">
                    </div>
                </div>
                <div class="cart-item-details">
                    <h2><%= serviceName %></h2>
                    <p class="cart-price">$<%= price %></p>
                    <p>Date: <%= date %></p>
                    <p>Time: <%= time %></p>
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
            <button type="submit" class="checkout-btn">Checkout</button>
        </form>
    </div>
    <jsp:include page="../html/footer.html" />
</body>
</html>
