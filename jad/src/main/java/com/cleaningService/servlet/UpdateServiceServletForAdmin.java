/*Name: Thiri Lae Win
Class: DIT/FT/2A/23
ADM Num: 2340739*/
package com.cleaningService.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.cleaningService.dao.ServiceDAO;
import com.cleaningService.model.Service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateServiceServletForAdmin")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB threshold
    maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
    maxRequestSize = 1024 * 1024 * 50    // 50MB max request size
)
public class UpdateServiceServletForAdmin extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Path where images will be uploaded in the project folder
    private static final String IMAGE_UPLOAD_DIRECTORY = "C:/SP_DIT/DIT_YR2_SEM2/JAD/assignment2/jad/jad/src/main/webapp/gallery";

    public UpdateServiceServletForAdmin() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("serviceName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int categoryId = Integer.parseInt(request.getParameter("category"));
        int serviceId = Integer.parseInt(request.getParameter("serviceId"));

        // Handle file part (image upload)
        Part filePart = request.getPart("serviceImage");


        String fileName = filePart != null ? filePart.getSubmittedFileName() : "";



        // Sanitize the file name (replace spaces and special characters)
        if (fileName != null && !fileName.isEmpty()) {
            // Remove or replace any special characters and spaces
            fileName = sanitizeFileName(fileName);
        }

        // Image Upload Path (ensure this directory exists in the project)
        String uploadPath = IMAGE_UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String imagePath = "";  // Path to store in DB
        if (filePart != null && fileName != null && !fileName.isEmpty()) {
            File uploadedFile = new File(uploadPath + File.separator + fileName);
            try (InputStream inputStream = filePart.getInputStream();
                 java.io.OutputStream outputStream = new java.io.FileOutputStream(uploadedFile)) {
                byte[] buffer = new byte[4096];
                int bytesRead;
                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }
            }
            // Store the relative path to the image for the database
            imagePath = "gallery/" + fileName;  // Relative path to the 'gallery' folder
        }

        if(imagePath == "") {
        	Service service = new Service();
        	ServiceDAO serviceDAO = new ServiceDAO();

        	service = serviceDAO.retrieveServiceById(serviceId);
        	imagePath = service.getImage();
        }

        ServiceDAO serviceDAO = new ServiceDAO();
        Service service = new Service();
        service.setName(name);
        service.setDescription(description);
        service.setCategory_id(categoryId);
        service.setPrice(price);
        service.setImage(imagePath);
        service.setId(serviceId);

        boolean isUpdated = serviceDAO.updateService(service);

        if (isUpdated) {
            request.setAttribute("message", "Service updated successfully");
        } else {
            request.setAttribute("error", "Failed to updated service.");
        }

        request.getRequestDispatcher("/jsp/adminRetrieveServices.jsp").forward(request, response);
    }

    // Method to sanitize the filename by replacing spaces and special characters
    private String sanitizeFileName(String fileName) {
        // Replace spaces with underscores and encode the filename
        fileName = fileName.replace(" ", "_");

        // Pattern to match special characters (not alphanumeric, -, _, .)
        Pattern pattern = Pattern.compile("[^a-zA-Z0-9._-]");
        Matcher matcher = pattern.matcher(fileName);

        // Replace all special characters with underscores
        fileName = matcher.replaceAll("_");

        // Ensure the filename is URL safe
        fileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8);

        return fileName;
    }
}
