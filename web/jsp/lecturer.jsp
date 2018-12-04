<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<html>
<head>
    <title>Lecturer page</title>
    <link rel="stylesheet" type="text/css" href="css/lecturer.css">
</head>
<body>
<%
    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    //setAttribute("lecturer", "lecturer");
    String lecturer = session.getAttribute("name").toString(); //request.getAttribute("lecturer");

    try {
        pst = conn.prepareStatement("SELECT user_name, description FROM user WHERE login = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, lecturer);

    ResultSet rs = pst.executeQuery();
    if(rs.next()){
        if (rs.getString("user_name") != null)
            request.setAttribute("lecturer_name", rs.getString("user_name"));
        else
            request.setAttribute("lecturer_name", "");
        if (rs.getString("description") != null)
            request.setAttribute("lecturer_description", rs.getString("description"));
        else
            request.setAttribute("lecturer_description", "");
    }

    try {
        pst = conn.prepareStatement("SELECT id, course_name, theme, description FROM course WHERE lecturer = ? ");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, lecturer);

    rs = pst.executeQuery();

    int n = 1;
    while(rs.next()){
        request.setAttribute("course_id"+n, rs.getString("id"));
        if (rs.getString("course_name") != null)
            request.setAttribute("course_name"+n, rs.getString("course_name"));
        else
            request.setAttribute("theme"+n, "");
        if (rs.getString("theme") != null)
            request.setAttribute("course_theme"+n, rs.getString("theme"));
        else
            request.setAttribute("description"+n, "");
        if (rs.getString("description") != null)
            request.setAttribute("course_description"+n, rs.getString("description"));
        else
            request.setAttribute("course_description"+n, "");
        n++;
    }

    try {
        pst = conn.prepareStatement("SELECT DISTINCT theme FROM course WHERE lecturer = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, lecturer);

    rs = pst.executeQuery();
    int t = 1;
    while(rs.next()){
        if ((rs.getString("theme") != null) && (!rs.getString("theme").equals(""))){
            request.setAttribute("theme"+t, rs.getString("theme"));
            t++;}
    }
%>
<jsp:include page="header/header.jsp"/>

<div class="title">Lecturer Page</div>
<div class="content">
<div class="lecturer">
    <h3><p align="center"><%=request.getAttribute("lecturer_name")%></p></h3>
    <h4><p align="center">lecturer</p></h4>
    <div id="personal_info">
        <div class="lecturer_info" >

                Specializations:
                <%
                    for (int i = 1; i < t; i++){
                %>
                <p align="center">- <%=request.getAttribute("theme"+i)%></p>
                <%
                    }
                %>

        </div>
        <div class="lecturer_info" >
            <details>
                <summary>Personal information</summary>
                <p id="persinfo"><%=request.getAttribute("lecturer_description")%></p>
            </details>
        </div>
    </div>
</div>
<div class = "course_column">
    <div class="courses_info">
        <div class="hdr">My courses:</div><br/>
        <%
            for (int i = 1; i < n; i++){
        %>
        <div class="course">
            <a class="courselink" href="course.jsp?course_id=<%=request.getAttribute("course_id"+i)%>"><h4><p align="center"><%=request.getAttribute("course_name"+i)%>: <%=request.getAttribute("course_theme"+i)%></p></h4></a>
            <div class = "descript"> <p><%=request.getAttribute("course_description"+i)%></p></div>
        </div>
        <%
            }
        %>
    </div>
</div>
</div>
<footer class="foot">
    <div class="footcont">
        <div class="contact">
            <p><strong>Contacts:</strong></p>
            <p>maxuaforever@gmail.com</p>
        </div>
        <div class="copyright">
            <p>&copy 2009 - 2018 All rights reserved</p>
        </div>
    </div>
</footer>

</body>
</html>