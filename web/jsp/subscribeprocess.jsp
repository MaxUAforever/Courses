<%@ page import = "java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;
    String user_login = session.getAttribute("name").toString();
    String course_id = request.getParameter("course_id");

    try {
        pst = conn.prepareStatement("INSERT INTO courses.subscribe (student, course) VALUES (?, ?)");
    } catch (SQLException e) {
        out.println("SQL query qreating error");
    }
    pst.setString(1, user_login);
    pst.setString(2, course_id);

    pst.executeUpdate();

    response.sendRedirect("course.jsp?course_id=" + course_id);
%>


