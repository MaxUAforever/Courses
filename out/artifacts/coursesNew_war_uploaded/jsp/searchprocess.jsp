<%@ page import = "java.sql.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String email = request.getParameter("user");

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
            out.println("User not found. " + rs.getInt(1) + " " + email);
            //TimeUnit.SECONDS.sleep(3);
            //response.sendRedirect("admin.jsp");
            //return;
        }
    }

    try {
        pst = conn.prepareStatement("SELECT * FROM `user` WHERE login LIKE ?");
    } catch (SQLException e) {
        out.println("SQL query qreating error");
    }

    pst.setString(1, email);

    rs = pst.executeQuery();
    if(rs.next()){
        request.setAttribute("email", rs.getString("login"));
        request.setAttribute("user_name", rs.getString("user_name"));
        request.setAttribute("description", rs.getString("description"));
        request.setAttribute("role", rs.getString("role"));
        request.setAttribute("flag", "1");
        %>
        <jsp:include page="admin.jsp" flush="true" />
        <%
        }
        else{
            request.setAttribute("textMsg", "Invalid user credentials!");
        %>
        <jsp:include page="admin.jsp" flush="true" />
        <%
    }

%>
