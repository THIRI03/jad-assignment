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

import com.cleaningService.model.Category;

@WebServlet("/ThirdParty_GetAllCategoriesServlet")
public class ThirdParty_GetAllCategoriesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Client client = ClientBuilder.newClient();
        String restUrl = "http://localhost:8081/user-ws/category/getAllCategories";
        WebTarget target = client.target(restUrl);
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response resp = invocationBuilder.get();

        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
            // Retrieve all categories from REST API
            List<Category> categories = Arrays.asList(resp.readEntity(Category[].class));

            // Forward categories to JSP
            request.setAttribute("categories", categories);
            RequestDispatcher rd = request.getRequestDispatcher("third-party-cleaner-service/ThirdPartyCategories.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("err", "CategoriesNotFound");
            RequestDispatcher rd = request.getRequestDispatcher("third-party-cleaner-service/error.jsp");
            rd.forward(request, response);
        }
    }
}
