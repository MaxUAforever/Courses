<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

    <%
        Class.forName("com.mysql.jdbc.Driver");

        String courseID = request.getParameter("course_title");
        String lectureTitle = request.getParameter("lecture_title");
        String desc = request.getParameter("description");
        String text = request.getParameter("text");

        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
        PreparedStatement pst = null;

        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();


        try {
            pst = conn.prepareStatement("INSERT INTO `lesson` (course, less_name, description, material) VALUES (?, ?, ?, ?)");
        } catch (SQLException e) {
            out.println("SQL querry qreating error");
        }

        pst.setInt(1, 1);
        pst.setString(2, lectureTitle);
        pst.setString(3, desc);
        pst.setString(4, text);


        /*if (*/pst.executeUpdate();/* == 1) {
            request.setAttribute("textMsg", "User is successfully created!");
        }*/

        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();

    %>
