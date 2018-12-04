<%@ page import = "java.sql.*" %>
<%@ page import="java.util.concurrent.TimeUnit" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //String id_course = request.getAttribute("id_course");
    String  course_id = "1";

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT course_name, theme, description FROM course WHERE id=?");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }

    pst.setString(1, course_id);

    ResultSet rs = pst.executeQuery();
    if(rs.next()){
        request.setAttribute("course_name", rs.getString("course_name"));
        request.setAttribute("course_theme", rs.getString("theme"));
        request.setAttribute("course_description", rs.getString("description"));
    }

    try {
        pst = conn.prepareStatement("SELECT id, less_name, description FROM lesson WHERE course=?");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }

    pst.setString(1, course_id);

    rs = pst.executeQuery();
    if(rs.next()){
        request.setAttribute("less_id", rs.getString("id"));
        request.setAttribute("less_name", rs.getString("less_name"));
        request.setAttribute("less_description", rs.getString("description"));
        %>
        <!--<h3><span>-</span><a href="#"></a></h3>
        <h3><span>-</span><a href="#">Lecture 2</a></h3>
        <h3><span>-</span><a href="#">Lecture 3</a></h3>-->
        <jsp:include page="course.jsp" flush="true" />
        <%
    }
    response.sendRedirect("course.jsp");
%>
