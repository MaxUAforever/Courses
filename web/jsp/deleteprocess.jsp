<%@ page import = "java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String email = request.getParameter("q");
    System.out.println(email);
    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT count(*) FROM user WHERE login=?");
    } catch (SQLException e) {
        out.println("SQL query qreating error");
    }
    pst.setString(1, email);

    ResultSet rs = pst.executeQuery();
    if(rs.next()){
        if (rs.getInt(1) == 0) {
            //TimeUnit.SECONDS.sleep(3);
            //response.sendRedirect("admin.jsp");
            //return;
        }
    }

    try {
        pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }
    pst.executeQuery();

    try {
        pst = conn.prepareStatement("DELETE FROM `user` WHERE login=?");
    } catch (SQLException e) {
        out.println("SQL query qreating error");
    }

    pst.setString(1, email);

    if (pst.executeUpdate() == 1){
        request.setAttribute("textMsg", "User is deleted!");
        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();
    %>
        <jsp:include page="admin.jsp" flush="true" />
    <%
    }
    else{
        request.setAttribute("textMsg", "User is deleted!");
        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();
    %>
        <jsp:include page="admin.jsp" flush="true" />
    <%
    }
%>
