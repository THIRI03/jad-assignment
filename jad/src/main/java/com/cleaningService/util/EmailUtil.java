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
   try {
        // Create the email message
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);

     // Add content as a part
        MimeBodyPart textPart = new MimeBodyPart();
        textPart.setContent(messageContent, "text/html");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(textPart);

        // Check and attach file if exists
        if (attachmentPath != null) {
            File file = new File(attachmentPath);
            if (file.exists()) {
                MimeBodyPart attachmentPart = new MimeBodyPart();
                attachmentPart.attachFile(file);
                multipart.addBodyPart(attachmentPart);
                System.out.println("DEBUG: Attached file: " + file.getAbsolutePath());
            } else {
                System.out.println("DEBUG: Attachment file not found.");
            }
        }

        message.setContent(multipart);

        // Print message content for debugging
        System.out.println("DEBUG: Email message content: " + messageContent);

        Transport.send(message);
        System.out.println("DEBUG: Email sent successfully!");
    } catch (Exception e) {
        e.printStackTrace();
    }
}
}