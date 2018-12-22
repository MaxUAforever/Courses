<%@ page import = "java.sql.*" %>
<%@ page import="java.util.concurrent.TimeUnit" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String lecture_id = request.getParameter("lecture_id");

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT lesson.course FROM `lesson` WHERE lesson.id LIKE ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }
    pst.setString(1, lecture_id);
    ResultSet rs = pst.executeQuery();
    String course_id = "";

    if(rs.next()){
        System.out.println(rs.getString("course"));
        course_id = rs.getString("course");
    }

    try {
        pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }
    pst.executeQuery();

    try {
        pst = conn.prepareStatement("DELETE FROM `lesson` WHERE id LIKE ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }
    pst.setString(1, lecture_id);

    if (pst.executeUpdate() == 1){
        request.setAttribute("textMsg", "Lecture deleted!");
        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();
        response.sendRedirect("course.jsp?course_id="+course_id+"&textMsg=1");
    }
    else{

        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();
        response.sendRedirect("course.jsp?course_id="+course_id+"&textMsg=0");

        }

%>
