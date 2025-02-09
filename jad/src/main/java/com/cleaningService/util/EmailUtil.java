package com.cleaningService.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    // Method to send a simple email with content, including service and price details
    public static void sendEmail(String toEmail, String subject, String messageContent) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");  // Gmail SMTP server
        props.put("mail.smtp.port", "587");

        // Sender email credentials
        String senderEmail = "sparklewithshiny@gmail.com";
        String senderPassword = "altx oqpb ztga hecm";  // Replace this with a secure password

        // Create the session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        // Create the email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setContent(messageContent, "text/html; charset=utf-8");

        // Send the email
        Transport.send(message);
        System.out.println("Email sent successfully to " + toEmail);
    }
}
