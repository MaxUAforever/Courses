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
    /*else {
        String course_name = "";
        String course_theme = "";
        String course_description = "";
        Class.forName("com.mysql.jdbc.Driver");

        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
        PreparedStatement pst = null;

        try {
            pst = conn.prepareStatement("REPLACE INTO course(id, course_name, theme, description) VALUES(?,?,?,?)");
        } catch (SQLException e) {
            out.println("SQL querry qreating error");
        }
        pst.setString(1, course_id);
        pst.setString(2, course_name);
        pst.setString(3, course_theme);
        pst.setString(4, course_description);

        if (pst.executeUpdate() == 1) {
            request.setAttribute("textMsg", "User is successfully edited!");
        }
    }*/

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