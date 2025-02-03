<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.cleaningService.dao.ServiceDAO" %>
<%@ page import="com.cleaningService.model.Service" %>
<%@ include file="authCheck.jsp" %>
<%-- <%@ include file="../html/adminNavbar.html" %> --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Service Photo</title>
    <style>
        /* Basic body and container styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* Card container style */
        .card {
            background-color: white;
            width: 400px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        label {
            font-size: 16px;
            color: #555;
            display: block;
            margin-bottom: 10px;
            text-align: left;
        }

        input[type="text"], button {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        /* Styling for the popup */
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            border-radius: 8px;
            width: 300px;
            text-align: center;
        }

        .popup img {
            width: 100px;
            height: 100px;
            margin: 10px;
            cursor: pointer;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .popup button {
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 4px;
            padding: 10px;
            cursor: pointer;
            font-size: 16px;
        }

        .popup button:hover {
            background-color: #c82333;
        }

        /* Image preview styling */
        #selectedImage {
            display: none;
            max-width: 100%;
            height: auto;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <!-- Card containing the form -->
    <div class="card">
        <h2>Update Service Photo</h2>

        <!-- Image preview -->
        <img id="selectedImage" src="#" alt="Selected Image" />

        <form id="updateForm" method="POST" action="<%=request.getContextPath() %>/updatePhoto">
            <!-- Hidden input field with serviceId retrieved from the session -->
            <input type="hidden" name="serviceId" value="<%= request.getParameter("serviceId") %>">
            <button type="button" onclick="showPopup()">Choose Photo</button>
            <input type="text" id="photoInput" name="photo" readonly><br><br>
            <input type="submit" value="Update Photo">
        </form>
    </div>

    <!-- Popup for selecting an image -->
    <div class="overlay" id="overlay"></div>
    <div class="popup" id="popup">
        <h3>Select a Photo</h3>
        <div id="gallery"></div>
        <button onclick="closePopup()">Cancel</button>
    </div>

    <script>
    const contextPath = '<%= request.getContextPath() %>';

        function showPopup() {
            fetch(contextPath+'/updatePhoto', {
                method: 'GET'
            })
            .then(response => response.json())
            .then(data => {
                const galleryDiv = document.getElementById('gallery');
                galleryDiv.innerHTML = '';
                data.forEach(imagePath => {
                    const imgElement = document.createElement('img');
                    imgElement.src = contextPath+imagePath;
                    imgElement.style.cursor = 'pointer';
                    imgElement.onclick = function () {
                        selectPhoto(imagePath);
                    };
                    galleryDiv.appendChild(imgElement);
                });

                document.getElementById('popup').style.display = 'block';
                document.getElementById('overlay').style.display = 'block';
            })
            .catch(error => console.error('Error loading images:', error));
        }

        function closePopup() {
            document.getElementById('popup').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }

        function selectPhoto(imagePath) {
            document.getElementById('photoInput').value = imagePath;

            const selectedImage = document.getElementById('selectedImage');
            selectedImage.src = imagePath;
            selectedImage.style.display = 'block'; 

            closePopup();
        }
    </script>
</body>
</html>
