<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <title>Course Title</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type = "text/css" href="css/course.css">
</head>
<body>
<!-- Title block -->
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
        out.println("SQL query creating error");
    }

    pst.setString(1, course_id);

    rs = pst.executeQuery();
    int n = 1;
    while(rs.next()){
        request.setAttribute("less_id"+n, rs.getString("id"));
        request.setAttribute("less_name"+n, rs.getString("less_name"));
        request.setAttribute("less_description"+n, rs.getString("description"));
        n++;
        %>
        <!--<h3><span>-</span><a href="#"></a></h3>
        <h3><span>-</span><a href="#">Lecture 2</a></h3>
        <h3><span>-</span><a href="#">Lecture 3</a></h3>
        -->
        <%
    }
    //response.sendRedirect("course.jsp");
%>
<div id="coursetitle">
    <h1 id="title"><%=request.getAttribute("course_name")%></h1>
    <div id="voiceBlock"></div>
    <h4 id="voice">100 voices</h4>
    <div class="starsRate">
        <span>&#9734;</span>
        <span>&#9734;</span>
        <span>&#9734;</span>
        <span>&#9734;</span>
        <span>&#9734;</span>
    </div>
</div>
<div id="titleLine">
    <hr align="center" width="95%" size="2" color="#000000" />
    <br />
</div>
</div>
<!-- End title block -->
<!-- Main block -->
<!-- navigate block -->
<div class="leftCol">
    <div id="navig">
        <h2 id="navTitle">Education plan</h2>
        <%
            for (int i = 1; i < n; i++){
        %>
        <h3><span>-</span><a href="#">Lecture <%=i%></a></h3>
        <!--<h3><span>-</span><a href="#">Lecture 2</a></h3>
        <h3><span>-</span><a href="#">Lecture 3</a></h3>-->
        <%
            }
        %>
    </div>

    <div id="addLect">
        <button type="button" name="button">Add lecture</button>
    </div>
    <div id="addExam">
        <button type="button" name="button">Add exam</button>
    </div>
</div>
<!-- End navigate block -->
<!-- main part -->
<div class="rightCol">
    <div id="courseInfo">
        <h2 id="courseInfoTitle"><%=request.getAttribute("course_name")%></h2>
        <div id="themeBlock">
            <h3 id="theme">Theme:</h3>
            <div id="themeOfCourse"><%=request.getAttribute("course_theme")%></div>
        </div>
        <h3 id="desc">Description:</h3>
        <div id="text">
            <p id="lorem"><%=request.getAttribute("course_description")%></p>
        </div>
        <div id="buttOfCourseInfo">
            <button type="button" name="button">Edit</button>
            <button type="button" name="button">Delete</button>
        </div>
    </div>

    <h2 id="lessonsTitle">Lessons</h2>

    <%
        for (int i = 1; i < n; i++){
    %>
    <div id="lectureInfo">
        <div id="lectureHead">
            <h5 id="lessonNum">Lecture <%=i%></h5>
            <h3 id="lectureInfoTitle"><a href="#"><%=request.getAttribute("less_name"+i)%></a></h3>
        </div>
        <div id="text">
            <p id="lorem"><%=request.getAttribute("less_description"+i)%></p>
        </div>
        <div id="bottom">
            <h3><a id="testRef" href="#">Test</a></h3>
            <div id="buttOfLectureInfo">
                <button type="button" name="button">Edit</button>
                <button type="button" name="button">Delete</button>
            </div>
        </div>
    </div>
    <%
        }
    %>

    <!--<div id="lectureInfo">
        <div id="lectureHead">
            <h5 id="lessonNum">Lecture 2</h5>
            <h3 id="lectureInfoTitle"><a href="#"><%//=request.getAttribute("less_name2")%></a></h3>
        </div>
        <div id="text">
            <p id="lorem"><%//=request.getAttribute("less_description12")%></p>
        </div>
        <div id="bottom">
            <h3><a id="testRef" href="#">Add test</a></h3>
            <div id="buttOfLectureInfo">
                <button type="button" name="button">Edit</button>
                <button type="button" name="button">Delete</button>
            </div>
        </div>
    </div>

    <div id="lectureInfo">
        <div id="lectureHead">
            <h5 id="lessonNum">Lecture 3</h5>
            <h3 id="lectureInfoTitle"><a href="#"><%//=request.getAttribute("less_name3")%></a></h3>
        </div>
        <div id="text">
            <p id="lorem"><%//=request.getAttribute("less_description3")%></p>
        </div>
        <div id="bottom">
            <h3><a id="testRef" href="#">Add test</a></h3>
            <div id="buttOfLectureInfo">
                <button type="button" name="button">Edit</button>
                <button type="button" name="button">Delete</button>
            </div>
        </div>
    </div>-->

</div>

</body>
</html>