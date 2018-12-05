<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

    <%
        Class.forName("com.mysql.jdbc.Driver");
        String l_id = request.getParameter("lecture_id");
        String c_id = request.getParameter("course_id");
        String lectureTitle = request.getParameter("lecture_title");
        String desc = request.getParameter("description");
        String text = request.getParameter("text");

        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
        PreparedStatement pst = null;

        try {
            pst = conn.prepareStatement("INSERT INTO `lesson` (id, course, less_name, description, material) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE course = ?, less_name = ?, description = ?, material = ?");
        } catch (SQLException e) {
            out.println("SQL querry qreating error");
        }

        //pst.setString(1, request.getAttribute("lesson_id").toString());
        pst.setString(1, l_id);
        pst.setString(2, c_id);
        pst.setString(3, lectureTitle);
        pst.setString(4, desc);
        pst.setString(5, text);
        pst.setString(6, c_id);
        pst.setString(7, lectureTitle);
        pst.setString(8, desc);
        pst.setString(9, text);


        if (pst.executeUpdate() > 0) {
            request.setAttribute("textMsg", "Lecture edited!");
        }
        else{
            request.setAttribute("textMsg", "Lecture edit failed!");
        }

    %>
<jsp:include page="course.jsp?course_id=<%=c_id%>" flush="true" />