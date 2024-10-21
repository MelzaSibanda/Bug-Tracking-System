package com.thebugeye.util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    private Session session;
    private String email;  // Storing the email as a class-level variable

    public EmailUtil() {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Hardcoded email and password
        email = "melzasibanda@gmail.com";
        String password = "Philasande@08.;";

        // Check if email or password is null
        if (email == null || password == null) {
            System.out.println("Email or password is null!");
            throw new IllegalArgumentException("Email or password is not set.");
        }

        // Initialize the session
        session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        });
    }

    public void sendEmail(String to, String subject, String body) {
    try {
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(email));  // Use the hardcoded email
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject("Test Email");
        message.setText("This is a test email.");

        Transport.send(message);
        System.out.println("Email sent successfully to: " + to);
    } catch (MessagingException e) {
        e.printStackTrace();
        System.out.println("Failed to send email: " + e.getMessage());
    }
}

}
