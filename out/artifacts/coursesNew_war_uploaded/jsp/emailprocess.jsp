<%--
  Created by IntelliJ IDEA.
  User: Богдан
  Date: 05.12.2018
  Time: 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.util.Properties" %>
<%@ page import = "javax.mail.Message" %>
<%@ page import = "javax.mail.MessagingException" %>
<%@ page import = "javax.mail.PasswordAuthentication" %>
<%@ page import = "javax.mail.Session" %>
<%@ page import = "javax.mail.Transport" %>
<%@ page import = "javax.mail.internet.InternetAddress" %>
<%@ page import = "javax.mail.internet.MimeMessage" %>

<html>
<head>
    <title>Email</title>
    <script src="js/course.js"></script>
</head>
<body>
<%
    final String username = "sigmacoursesproject@gmail.com";
    final String password = "sigma12345sigma";

    String email_to = "maxuaforever@gmail.com";//request.getAttribute("email").toString();
    String subject = request.getAttribute("subject").toString();
    String text = request.getAttribute("text").toString();
    String page_to = request.getAttribute("page_to").toString();

    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");

    Session session_mail = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

    try {
        Message message = new MimeMessage(session_mail);
        message.setFrom(new InternetAddress("from-email@gmail.com"));
        message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(email_to));
        message.setSubject(subject);
        message.setText(text);

        Transport.send(message);

    } catch (MessagingException e) {
        System.out.println("Email not sent");
        throw new RuntimeException(e);
    } finally {
        %>
            <jsp:include page="<%=page_to%>" flush="true"/>
        <%
    }
%>
</body>
</html>
