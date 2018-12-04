<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<script src="js/course.js"></script>
</head>
<body>
<%
    System.out.println("Meow tut ");
    String course_id = request.getParameter("course_id");
    if (request.getParameter("edit").equals("false")) {
        request.setAttribute("edit", "true");
        System.out.println("Meow another");
        %>
    <jsp:include page="course.jsp?course_id=<%=course_id%>" flush="true" />
    <%
        //response.sendRedirect("course.jsp");

    }
    else {
        String course_lecturer = request.getParameter("course_lecturer");
        String course_name = request.getParameter("course_name");
        String course_theme = request.getParameter("course_theme");
        String course_description = request.getParameter("course_description");
        Class.forName("com.mysql.jdbc.Driver");

        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
        PreparedStatement pst = null;

            System.out.println(course_id + " " + course_name + " " + course_theme + " " + course_description);

        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();

        try {
            pst = conn.prepareStatement("REPLACE INTO course (id, lecturer, course_name, theme, description) VALUES(?,?,?,?,?)");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.setString(1, course_id);
        pst.setString(2, course_lecturer);
        pst.setString(3, course_name);
        pst.setString(4, course_theme);
        pst.setString(5, course_description);

        if (pst.executeUpdate() > 0) {
            request.setAttribute("textMsg", "Course edited!");
        }
        else
            request.setAttribute("textMsg", "Course edit failed!");
            try {
                pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
            } catch (SQLException e) {
                out.println("SQL query creating error");

            }
        %>
        <jsp:include page="course.jsp?course_id=<%=course_id%>" flush="true" />
        <%
    }

    //String edit = request.getAttribute("edit");

    /*Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT role FROM user WHERE (login LIKE ? AND hash_pass LIKE ?)");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }

    ResultSet rs = pst.executeQuery();
    if(rs.next()){
    }*/
%>
</body>
</html>