<%@ page import="com.cleaningService.util.EmailUtil" %>
<%@ page import="jakarta.mail.MessagingException" %>
<html>
<head>
    <title>Email Test</title>
</head>
<body>
    <h1>Email Test Page</h1>

    <%
        // Email details
        String toEmail = "kiwikate003@gmail.com";  // Replace with your own email to test
        String subject = "Test Email from Cleaning Service";
        String messageContent = "<h1>Test Email</h1><p>This is a test email from your web application.</p>";

        try {
            // Call EmailUtil to send the email
            EmailUtil.sendEmail(toEmail, subject, messageContent);

            out.println("<p>Email sent successfully to: " + toEmail + "</p>");
        } catch (MessagingException e) {
            e.printStackTrace();
            out.println("<p>Failed to send email. Error: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>
