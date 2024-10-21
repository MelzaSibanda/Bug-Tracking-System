/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.thebugeye.servlet;

/**
 *
 * @author 222001313
 */
import com.thebugeye.entity.Email;
import com.thebugeye.Dao.EmailDao;
import com.thebugeye.util.EmailUtil;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/sendEmails")
public class EmailServlet extends HttpServlet {

    @Inject
    private EmailDao emailDao; 

    @Inject
    private EmailUtil emailUtil; 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String recipient = request.getParameter("recipient");
        String subject = request.getParameter("subject");
        String body = request.getParameter("body");

        
        Email email = new Email();
        email.setRecipient(recipient);
        email.setSubject(subject);
        email.setBody(body);
        emailDao.saveEmail(email);

        try {
            // Send email
            emailUtil.sendEmail(recipient, subject, body); // Pass parameters to the method
            response.getWriter().write("Email has been sent to " + recipient + ".");
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception (optional)
            response.getWriter().write("Error sending email: " + e.getMessage());
        }
    }
}