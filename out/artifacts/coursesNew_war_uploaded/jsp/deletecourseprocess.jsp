<%@ page import = "java.sql.*" %>
<%@ page import="java.util.concurrent.TimeUnit" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String course_id = request.getParameter("course_id");

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }
    pst.executeQuery();

    try {
        pst = conn.prepareStatement("DELETE FROM course WHERE id LIKE ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, course_id);

    if (pst.executeUpdate() == 1){
        request.setAttribute("textMsg", "Course deleted!");
        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();
    %>
    <jsp:include page="allcourses.jsp" flush="true" />
    <%
    }
    else{
        request.setAttribute("textMsg", "Invalid course credentials!");
        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();
    %>
    <jsp:include page="course.jsp?course_id=<%=course_id%>" flush="true" />
    <%
        }
%>
