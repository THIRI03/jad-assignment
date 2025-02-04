<%-- 
    JAD-CA1
    Class-DIT/FT/2A/23
    Student Name: Moe Myat Thwe
    Admin No.: P2340362
--%>
<%@ include file="header.jsp" %>
<%@ include file="authCheck.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.util.*, java.sql.*, com.cleaningService.util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cart.css">
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">

  <%-- <script>
 
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
    </script>--%>  
</head>
<body>
    <div class="cart-container">
        <h1 class="cart-header">My Cart</h1>
        <p class="service-info">You have selected <span id="serviceCount">0</span> service(s) for checkout.</p>
        <form action="<%=request.getContextPath()%>/CartCheckoutServlet" method="post">
            <%
            String categoryIdParam = request.getParameter("category_id");
            String serviceIdParam = request.getParameter("service_id");
                List<Map<String, Object>> cart = (List<Map<String, Object>>) session.getAttribute("cart");

                if (cart == null || cart.isEmpty()) {
            %>
                <p class="empty-cart">Your cart is empty.</p>
            <%
                } else {
                    for (int i = 0; i < cart.size(); i++) {
                        Map<String, Object> item = cart.get(i);

                        int serviceId = Integer.parseInt(item.get("serviceId").toString());
                        String serviceName = "";
                        String image = "";
                        double price = 0.0;

                        try (Connection conn = DBConnection.getConnection();
                             PreparedStatement stmt = conn.prepareStatement(
                                 "SELECT name, image, price FROM service WHERE id = ?")) {
                            stmt.setInt(1, serviceId);
                            try (ResultSet rs = stmt.executeQuery()) {
                                if (rs.next()) {
                                    serviceName = rs.getString("name");
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
                    <input type="checkbox" name="selectedItems" value="<%= i %>" class="cart-checkbox" >
                    <div class="cart-item-image">
                        <img src="../<%= image %>" alt="<%= serviceName %>">
                    </div>
                </div>
                <div class="cart-item-details">
                    <h2><%= serviceName %></h2>
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
               <p>Subtotal: <span id="subtotal">$0.00</span></p>
               <p>GST (7%): <span id="gst">$0.00</span></p>
               <p>Discount (10%): <span id="discount">$0.00</span></p>
               <p><strong>Total Amount: <span id="totalAmount">$0.00</span></strong></p>
                <button type="submit" name="checkout" class="checkout-btn" value="true" onclick="validateCheckout(event)">Checkout</button>
            </div>
        </form>
    </div>
    <script>
    function updateSummary() {
    	 console.log("Running updateSummary...");
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
                const priceText = prices[index]?.textContent.trim().replace('$', '');
                console.log(`Price extracted for item ${index}: "${priceText}"`);
                
                const priceValue = parseFloat(priceText);

                if (!isNaN(priceValue)) {
                    subtotal += priceValue;
                    selectedCount++;
                } else {
                    console.warn(`Invalid price format: "${priceText}"`);
                }
            }
        });

        const gst = subtotal * 0.07;  // GST is 7%
        const discount = subtotal * 0.10;  // Discount is 10%
        const totalAmount = subtotal + gst - discount;
        
        console.log(`Subtotal: ${subtotal}, GST: ${gst}, Discount: ${discount}, Total Amount: ${totalAmount}`);

        serviceCount.innerText = selectedCount;
        subtotalElement.innerText = `$${subtotal.toFixed(2)}`;
        gstElement.innerText = `$${gst.toFixed(2)}`;
        discountElement.innerText = `$${discount.toFixed(2)}`;
        totalAmountElement.innerText = `$${totalAmount.toFixed(2)}`;
    }

    function validateCheckout(event) {
        const checkboxes = document.querySelectorAll('.cart-checkbox');
        const isAnySelected = Array.from(checkboxes).some(checkbox => checkbox.checked);

        if (!isAnySelected) {
            event.preventDefault();
            alert('Please select at least one service to proceed to checkout.');
        }
    }

    document.addEventListener('DOMContentLoaded', () => {
    	console.log('Page loaded. Running updateSummary.');
        updateSummary();

        // Add event listeners to checkboxes
        const checkboxes = document.querySelectorAll('.cart-checkbox');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', updateSummary);
        });
    });
</script>
    <jsp:include page="../html/footer.html" />
</body>
</html>
