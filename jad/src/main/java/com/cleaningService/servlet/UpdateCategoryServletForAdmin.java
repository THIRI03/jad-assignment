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

import com.cleaningService.dao.CategoryDAO;
import com.cleaningService.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateCategoryServletForAdmin")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB threshold
    maxFileSize = 1024 * 1024 * 10,      // 10MB max file size
    maxRequestSize = 1024 * 1024 * 50    // 50MB max request size
)
public class UpdateCategoryServletForAdmin extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String IMAGE_UPLOAD_DIRECTORY = "C:/SP_DIT/DIT_YR2_SEM2/JAD/assignment2/jad/jad/src/main/webapp/gallery";

    public UpdateCategoryServletForAdmin() {
        super();
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get category details from the form
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        // Handle file part (image upload)
        Part filePart = request.getPart("image");
        String fileName = filePart != null ? filePart.getSubmittedFileName() : "";

        // Sanitize the file name
        if (fileName != null && !fileName.isEmpty()) {
            fileName = sanitizeFileName(fileName);
        }

        // Image Upload Path
        String uploadPath = IMAGE_UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        String imagePath = ""; // Path to store in DB
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
            // Store the relative path for the image
            imagePath = "gallery/" + fileName;  // Relative path to 'gallery'
        }

        if(imagePath == "") {
        	Category category = new Category();
            CategoryDAO categoryDAO = new CategoryDAO();

        	category = categoryDAO.retrieveCategoryById(categoryId);
        	imagePath = category.getImage();
        }

        // Update the category in the database
        CategoryDAO categoryDAO = new CategoryDAO();
        Category category = new Category();
        category.setCategoryName(name);
        category.setDescription(description);
        category.setImage(imagePath);
        category.setId(categoryId);
        boolean isUpdated = categoryDAO.updateCategory(category);

        // Set a success or error message
        if (isUpdated) {
        	request.setAttribute("categoryId", categoryId);
            request.setAttribute("message", "Category updated successfully.");
        } else {
        	request.setAttribute("categoryId", categoryId);
            request.setAttribute("message", "Failed to update category.");
        }

        request.getRequestDispatcher("/jsp/adminUpdateCategory.jsp").forward(request, response);
    }

    // Method to sanitize the file name by replacing spaces and special characters
    private String sanitizeFileName(String fileName) {
        fileName = fileName.replace(" ", "_");

        // Pattern to match special characters (not alphanumeric, -, _, .)
        Pattern pattern = Pattern.compile("[^a-zA-Z0-9._-]");
        Matcher matcher = pattern.matcher(fileName);

        // Replace special characters with underscores
        fileName = matcher.replaceAll("_");

        // Ensure the filename is URL safe
        fileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8);

        return fileName;
    }
}
