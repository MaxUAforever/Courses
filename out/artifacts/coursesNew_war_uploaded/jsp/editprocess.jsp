<%@ page import = "java.sql.*" %>
<%@ page import="java.util.concurrent.TimeUnit" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String email = request.getParameter("email");
    String uname = request.getParameter("uname");
    String info = request.getParameter("info");
    String role = request.getParameter("role");

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT count(*) FROM user WHERE login=?");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }
    pst.setString(1, email);

    ResultSet rs = pst.executeQuery();
    if(rs.next()){
        if (rs.getInt(1) == 0) {
            request.setAttribute("textMsg", "Email isn't used!");
        %>
            <jsp:include page="admin.jsp" flush="true" />
        <%
        }
    }

    try {
        pst = conn.prepareStatement("SELECT hash_pass FROM user WHERE login=?");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }

    String pass = "";
    pst.setString(1, email);
    rs = pst.executeQuery();
    if(rs.next()){
        pass = rs.getString("hash_pass");
    }

    try {
        pst = conn.prepareStatement("INSERT INTO `user` (login, hash_pass, role, user_name, description) VALUES(?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE login = ?, hash_pass = ?, role = ?, user_name = ?, description = ?");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }

    pst.setString(1, email);
    pst.setString(2, pass);
    pst.setString(3, role);
    pst.setString(4, uname);
    pst.setString(5, info);
    pst.setString(6, email);
    pst.setString(7, pass);
    pst.setString(8, role);
    pst.setString(9, uname);
    pst.setString(10, info);

    if (pst.executeUpdate() > 0){
        request.setAttribute("textMsg", "User is edited!");
    %>
        <jsp:include page="admin.jsp" flush="true" />
    <%
    }
    else{
        request.setAttribute("textMsg", "Wrong user data!");
    %>
        <jsp:include page="admin.jsp" flush="true" />
    <%
    }
%>
