<%-- 
    Document   : sendEmail
    Created on : 09 Oct 2024, 13:50:12
    Author     : USER
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.thebugeye.entity.Email"%>
<%@page import="com.thebugeye.util.EmailUtil"%>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .message-container {
            width: 90%;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        footer {
            text-align: center;
            padding: 10px;
            margin-top: 40px;
            background-color: #17a2b8;
            color: white;
        }
    </style>
<%
    String recipient = request.getParameter("recipient");
    String subject = request.getParameter("subject");
    String body = request.getParameter("body");
    EmailUtil emailUtil = new EmailUtil(); // Make sure this is properly instantiated if using CDI

    try {
        emailUtil.sendEmail(recipient, subject, body);
        out.println("<h2>Email sent successfully to " + recipient + "!</h2>");
    } catch (Exception e) {
        out.println("<h2>Error sending email: " + e.getMessage() + "</h2>");
        // Print the stack trace to the server logs
        e.printStackTrace(); // This prints to the console/logs, not the JspWriter
    }
%>
<a href="admin.jsp">Return to admin</a>

