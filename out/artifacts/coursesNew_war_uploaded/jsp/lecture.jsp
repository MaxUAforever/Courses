<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <%
        String lecture_id = request.getParameter("lecture_id");

        Class.forName("com.mysql.jdbc.Driver");

        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
        PreparedStatement pst = null;

        try {
        pst = conn.prepareStatement("SELECT lesson.less_name, lesson.course, course.course_name, lesson.material FROM lesson INNER JOIN course ON lesson.course = course.id WHERE lesson.id=?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

        pst.setString(1, lecture_id);

        ResultSet rs = pst.executeQuery();
        if(rs.next()){
            request.setAttribute("less_name", rs.getString("less_name"));
            request.setAttribute("less_course", rs.getString("course"));
            request.setAttribute("less_course_name", rs.getString("course_name"));
            request.setAttribute("less_material", rs.getString("material"));
        }
    %>
    <script>addTextDiv(<%=request.getAttribute("less_material")%>)</script>
    <meta charset="utf-8">
    <title>Lecture</title>
    <link rel="stylesheet" href="css/lecture.css">
    <script type="text/javascript" src="js/lecture.js"></script>
</head>
<body>
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
<div id="lectBlock">
    <div id="lectHead">
        <h3><%=request.getAttribute("less_name")%></h3>
        <h3><a href="course.jsp?course_id=<%=request.getAttribute("less_course")%>"><%=request.getAttribute("less_course_name")%></a></h3>
    </div>
</div>
<div id="content"><%=request.getAttribute("less_material")%></div>
</body>
</html>