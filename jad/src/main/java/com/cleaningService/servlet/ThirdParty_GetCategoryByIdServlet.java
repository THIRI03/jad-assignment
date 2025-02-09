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

import com.cleaningService.model.Category;

/**
 * Servlet implementation class GetCategoryById
 */
@WebServlet("/ThirdParty_GetCategoryByIdServlet")
public class ThirdParty_GetCategoryByIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThirdParty_GetCategoryByIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
    	// Retrieve category ID from the request
        String categoryId = request.getParameter("categoryId");

        // Build REST client and make the request
        Client client = ClientBuilder.newClient();
        String restUrl = "http://localhost:8081/user-ws/category/getCategory/" + categoryId;
        WebTarget target = client.target(restUrl);
        Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
        Response resp = invocationBuilder.get();

        System.out.println("Status: " + resp.getStatus());

        if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
            // Request succeeded, read and forward the category details
            System.out.println("Category found successfully.");
            Category category = resp.readEntity(Category.class);

            request.setAttribute("category", category);
            String url = "third-party-cleaner-service/categoryDetails.jsp";  // Update with your JSP file name
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        } else {
            // Handle case where category is not found
            System.out.println("Category not found.");
            request.setAttribute("err", "CategoryNotFound");
            String url = "third-party-cleaner-service/categoryDetails.jsp";  // Update with your JSP file name
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
