<%@ page import = "java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;
    String user_login = session.getAttribute("name").toString();
    String course_id = request.getParameter("course_id");

    try {
        pst = conn.prepareStatement("INSERT INTO subscribe (student, course) VALUES (?, ?)");
    } catch (SQLException e) {
        out.println("SQL query qreating error");
    }
    pst.setString(1, user_login);
    pst.setString(2, course_id);

    pst.executeUpdate();

    try {
        pst = conn.prepareStatement("SELECT lecturer FROM course WHERE id=?");
    } catch (SQLException e) {
        out.println("SQL query qreating error");
    }
    pst.setString(1, course_id);

    ResultSet rs = pst.executeQuery();
    String lecturer = "";
    if (rs.next()){
        lecturer = rs.getString("lecturer");
    }

    request.setAttribute("email", lecturer);
    request.setAttribute("subject", "New subscribe");
    request.setAttribute("text", "New student subscribe on your course!");
    request.setAttribute("page_to", "course.jsp?course_id=" + course_id);

    response.sendRedirect("course.jsp?course_id=" + course_id);
    %>


