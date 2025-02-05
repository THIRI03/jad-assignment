package com.cleaningService.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;
import java.io.File;
import java.io.IOException;

public class EmailUtil {
    // Method to send email with subject and content
    public static void sendEmailWithAttachment(String toEmail, String subject, String messageContent, String attachmentPath) throws MessagingException, IOException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");  // Gmail SMTP server
        props.put("mail.smtp.port", "587");

        // Authenticate with sender email credentials
        String senderEmail = "sparklewithshiny@gmail.com";
        String senderPassword = "altx oqpb ztga hecm";  // Update this to a secure password

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

        // Email body (HTML)
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setContent(messageContent, "text/html; charset=utf-8");

        // Create multipart message and add the body part
        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(textPart);

        // Attach file if available
        if (attachmentPath != null) {
            File file = new File(attachmentPath);
            if (file.exists()) {
                MimeBodyPart attachmentPart = new MimeBodyPart();
                attachmentPart.attachFile(file);
                multipart.addBodyPart(attachmentPart);
            } else {
                System.out.println("Attachment file not found: " + attachmentPath);
            }
        }

        // Set the content of the message
        message.setContent(multipart);

        // Send the email
        Transport.send(message);
        System.out.println("Email sent successfully!");
    }
}
