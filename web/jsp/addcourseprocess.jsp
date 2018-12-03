<%--
  Created by IntelliJ IDEA.
  User: User646
  Date: 03.12.2018
  Time: 13:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <script src="js/course.js"></script>
</head>
<body>
<%

    //String course_lecturer = request.getParameter("course_lecturer");
    String course_name = request.getParameter("course_title");
    String course_theme = request.getParameter("theme");
    String course_description = request.getParameter("description");


    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    System.out.println(course_name + " " + course_theme + " " + course_description);


    try {
        pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.executeQuery();

    try {

        pst = conn.prepareStatement("INSERT INTO course (lecturer, course_name, theme, description) VALUES (?, ?, ?, ?)");

    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, session.getAttribute("name").toString());
    pst.setString(2, course_name);
    pst.setString(3, course_theme);
    pst.setString(4, course_description);

    if (pst.executeUpdate() > 0) {
        request.setAttribute("textMsg", "Course created!");
    } else
        request.setAttribute("textMsg", "Course creating failed!");

    try {
        pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
    } catch (SQLException e) {
        out.println("SQL query creating error");

    }
    %>

<jsp:include page="lecturer.jsp" flush="true" />

</body>
</html>