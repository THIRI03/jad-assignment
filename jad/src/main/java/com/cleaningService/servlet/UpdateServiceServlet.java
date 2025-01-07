//    JAD-CA1
//    Class-DIT/FT/2A/23
//    Student Name: Thiri Lae Win
//    Admin No.: P2340739

package com.cleaningService.servlet;

import java.io.IOException;
import com.cleaningService.dao.ServiceDAO;
import com.cleaningService.model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateServiceServlet")
public class UpdateServiceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Retrieve the serviceId and other form parameters
        String serviceIdStr = request.getParameter("serviceId");
        int serviceId = Integer.parseInt(serviceIdStr);
        
        // Get the updated form data
        String serviceName = request.getParameter("serviceName");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String categoryStr = request.getParameter("category");
        
        try {
            // Parse price and category
            double price = Double.parseDouble(priceStr);
            int categoryId = Integer.parseInt(categoryStr);

            // Create a Service object with updated values
            Service serviceToUpdate = new Service();
            serviceToUpdate.setId(serviceId);
            serviceToUpdate.setName(serviceName);
            serviceToUpdate.setDescription(description);
            serviceToUpdate.setPrice(price);
            serviceToUpdate.setCategory_id(categoryId);

            // Update the service in the database
            ServiceDAO serviceDAO = new ServiceDAO();
            boolean isUpdated = serviceDAO.updateService(serviceToUpdate);

            // Redirect based on success/failure
            if (isUpdated) {
                response.sendRedirect(request.getContextPath() + "/jsp/adminRetrieveServices.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/jsp/adminRetrieveServices.jsp?error=Update failed");
            }
        } catch (NumberFormatException e) {
            // Handle invalid price or category values
            response.sendRedirect(request.getContextPath() + "/updateService.jsp?error=Invalid price or category");
        }
    }
}
