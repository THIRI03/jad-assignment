package com.cleaningService.servlet;

import java.io.IOException;
import java.sql.Connection;

import com.cleaningService.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/testConnection")
public class testConnection extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try (Connection connection = DBConnection.getConnection()) {
            resp.getWriter().write("Connection successful: " + connection);
        } catch (Exception e) {
            resp.getWriter().write("Connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

