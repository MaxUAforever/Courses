<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        Class.forName("com.mysql.jdbc.Driver");

        String courseID = request.getParameter("course_id");
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

        pst.setString(1, courseID);
        pst.setString(2, lectureTitle);
        pst.setString(3, desc);
        pst.setString(4, text);

        if (pst.executeUpdate() > 0) {
            request.setAttribute("textMsg", "Lecture created!");
        }
        else{
            request.setAttribute("textMsg", "Lecture create failed!");
        }

        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();
    %>
    <jsp:include page="course.jsp?course_id=<%=courseID%>" flush="true" />
</body>
</html>
