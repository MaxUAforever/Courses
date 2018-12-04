<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>

<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*,javax.activation.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>

<%
    String result;

    String subject = request.getParameter("subject");
    String mess = "";
    String[] email;
    int n = 0;

    /*switch(subject) {
        case "registration":
            n = 1;
            email = new String[n];
            email[0] = request.getParameter("email");
            break;
    default:
        email = new String[1];
            break;
    }*/

    n = 1;
    for(int i = 0; i < n; i++) {
        // Recipient's email ID needs to be mentioned.
        String to = "default1717@gmail.com";//email[i];

        // Sender's email ID needs to be mentioned
        String from = "maxuaforever@gmail.com";

        // Assuming you are sending email from localhost
        String host = "localhost";

        // Get system properties object
        Properties properties = System.getProperties();

        // Setup mail server
        properties.setProperty("mail.smtp.host", host);

        // Get the default Session object.
        Session mailSession = Session.getDefaultInstance(properties);

        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(mailSession);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(to));
            // Set Subject: header field

            message.setSubject("Info");

            // Now set the actual message
            message.setText("Ty poluchil pismo?");

            // Send message
            Transport.send(message);
            out.println("Sent message successfully....");
        } catch (MessagingException mex) {
            mex.printStackTrace();
            out.println("Error: unable to send message....");
        }
    }
%>
