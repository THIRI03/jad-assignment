package com.cleaningService.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {
	// Method to send email with subject and content
    public static void sendEmail(String toEmail, String subject, String messageContent) throws MessagingException {
        // Configure SMTP server settings
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");  // Gmail SMTP server
        props.put("mail.smtp.port", "587");

        // Authenticate with sender email credentials
        String senderEmail = "sparklewithshiny@gmail.com";
        String senderPassword = "altx oqpb ztga hecm";

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        try {
            // Compose the message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(senderEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);

            // Email body content
            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setContent(messageContent, "text/html");

            // Multipart message (supports attachments if needed)
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);

            message.setContent(multipart);

            // Send the email
            Transport.send(message);

            System.out.println("Email sent successfully!");
        } catch (MessagingException e) {
            e.printStackTrace();
            throw e;
        }
    }
}
