<%@ page import = "java.sql.*" %>

<%
    String username = request.getParameter("uname");
    String password = request.getParameter("password");

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT role FROM user WHERE (login LIKE ? AND hash_pass LIKE ?)");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }

    pst.setString(1, username);
    pst.setString(2, password);

    ResultSet rs = pst.executeQuery();
    if(rs.next()){
        if (rs.getString(1).equals("admin")) {
            response.sendRedirect("admin.jsp");
            session.setAttribute("name", username);
            session.setAttribute("role", "admin");
        }
        else if (rs.getString(1).equals("student")) {
            response.sendRedirect("student.jsp");
            session.setAttribute("name", username);
            session.setAttribute("role", "student");
        }
        else if (rs.getString(1).equals("lecturer")) {
            response.sendRedirect("lecturer.jsp");
            session.setAttribute("name", username);
            session.setAttribute("role", "lecturer");
        }
        else{
            request.setAttribute("textMsg", "Wrong email or password!");
        %>
            <jsp:include page="login.jsp" flush="true" />
        <%
        }
    }
    else{
        request.setAttribute("textMsg", "Wrong email or password!");
    %>
        <jsp:include page="login.jsp" flush="true" />
    <%
    }
%>
