package com.cleaningService.servlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Invocation;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.cleaningService.model.Service;

@WebServlet("/ThirdParty_GetServicesByCategoryServlet")
public class ThirdParty_GetServicesByCategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the category ID from the request parameters
        String categoryId = request.getParameter("category_id");

        if (categoryId == null || categoryId.isEmpty()) {
            // Redirect to categories page if category ID is missing
            response.sendRedirect(request.getContextPath() + "/ThirdParty_GetAllCategoriesServlet");
            return;
        }

        // Build the REST request to fetch services for the selected category
        Client client = ClientBuilder.newClient();
        String restUrl = "http://localhost:8081/user-ws/service/getServicesByCategory/" + categoryId;
        WebTarget target = client.target(restUrl);
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response resp = invocationBuilder.get();

        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
            // Successfully retrieved services
            List<Service> services = Arrays.asList(resp.readEntity(Service[].class));
            request.setAttribute("services", services);
        } else {
            // No services found, set an error message
            request.setAttribute("errorMessage", "No services found for the selected category.");
        }

        // Forward the request to the JSP page for displaying services or an error message
        RequestDispatcher rd = request.getRequestDispatcher("third-party-cleaner-service/getServicesByCategories.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Call doGet to handle POST requests
        doGet(request, response);
    }
}
