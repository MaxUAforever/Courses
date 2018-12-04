<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<html>
<head>
    <title>Lecturer page</title>
    <link rel="stylesheet" type="text/css" href="css/lecturer.css">
    <script src="js/course.js"></script>
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
<!--<header>
    <div class = "logo">
        <img src="header/logo.png" alt="logo">
    </div>
    <headercount>
        <div class="item"><a href="allcourses.jsp">Courses</a></div>
        <div class="item"><a href="">About</a></div>
        <div class="item">
            <form action="allcourses.jsp" method="post" class="searchcontainer">
                <p><input type="search" name="q" placeholder="Search courses">
                    <input type="image" id = "buttonSearch" src="header/search.png" alt="Search">
                </p>
            </form>
        </div>
    </headercount>
    <div class="reg">
        <div id="adminimg"></div>
        <a href="lecturer.jsp" class="header_name"><%/*out.print(session.getAttribute("name"));*/%></a>
        <br>
        <a href="login.jsp">Log Out</a>
    </div>
</header>-->

<div class="title"><span><h3>Lecturer Page</h3></span></div>

<div class="lecturer">
    <center>
        <div class = "circle">
            <img src="img/lecturer/customer-login.png" alt="Users photo">
        </div>
    </center>
    <div class="info">
        <h3><p align="center"><%=request.getAttribute("lecturer_name")%></p></h3>
        <h4><p align="center">Lecturer</p></h4>
        <span><h4><p align="center">Specializations:</p></h4></span>
        <%
            for (int i = 1; i < t; i++){
        %>
        <h5><p align="center">- <%=request.getAttribute("theme"+i)%></p></h5>
        <%
            }
        %>
        <h5><p align="center"><a href="list_of_students.jsp">Subscribed students</a></p></h5>
    </div>
</div>
<div class = "course_column">
    <div class="personal_info">
        <h3><p align="center">Personal information</p></h3>
        <div class="lecturer_info">
            <p><%=request.getAttribute("lecturer_description")%></p>
        </div>
    </div>

    <div class="courses_info">
        <p> <h5><p align="right"><a class="addcourselink" href="addcourse.jsp">+ Add</a></p></h5> <h3><p align="center">Courses:</p></h3></p>
        <%
            for (int i = 1; i < n; i++){
        %>
        <div class="course">
            <a class="courselink" href="course.jsp?course_id=<%=request.getAttribute("course_id"+i)%>"> <h4><p align="center"><%=request.getAttribute("course_name"+i)%>: <%=request.getAttribute("course_theme"+i)%></p></h4></a>
            <p><%=request.getAttribute("course_description"+i)%></p>
        </div>
        <%
            }
        %>
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

<% if (request != null && request.getAttribute("textMsg") != null){ %>
<script type="text/javascript">
    openPopUp();
</script>
<% }

%>

</body>
</html>