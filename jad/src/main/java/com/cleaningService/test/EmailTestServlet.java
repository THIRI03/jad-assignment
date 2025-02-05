package com.cleaningService.test;

import com.cleaningService.util.EmailUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/email-test")  // No need to configure web.xml
public class EmailTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String toEmail = "kiwikate003@gmail.com.com";  // Replace with your test email
        String subject = "Test Email from Cleaning Service";
        String messageContent = "<h1>Test Email</h1><p>This is a test email.</p>";

        try {
            EmailUtil.sendEmail(toEmail, subject, messageContent);
            response.getWriter().println("Email sent successfully to: " + toEmail);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Failed to send email. Error: " + e.getMessage());
        }
    }
}
