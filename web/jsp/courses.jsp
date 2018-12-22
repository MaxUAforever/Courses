<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Main page</title>
    <link rel="stylesheet" href="css/page_with_courses.css">
</head>
<body>

<%
    //request.setAttribute("course_id", "4");
    //String course_id = "1";

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT course.id, course.lecturer, course.course_name, course.theme, course.description, COUNT(lesson.id) AS less_count FROM course LEFT JOIN lesson ON course.id = lesson.course GROUP BY course.id");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }

    ResultSet rs = pst.executeQuery();
    int n = 1;
    if(rs.next()){
        request.setAttribute("course_id"+n, rs.getString("id"));
        request.setAttribute("course_lecturer"+n, rs.getString("lecturer"));
        request.setAttribute("course_name"+n, rs.getString("course_name"));
        request.setAttribute("course_theme"+n, rs.getString("theme"));
        request.setAttribute("course_description",+n rs.getString("description"));
        request.setAttribute("course_less_count"+n, rs.getString("less_count"));
        n++;
    }
%>
<!--<h3><span>-</span><a href="#"></a></h3>
<h3><span>-</span><a href="#">Lecture 2</a></h3>
<h3><span>-</span><a href="#">Lecture 3</a></h3>
-->

<div class="leftMainCol">
    <div id="specs">
        <h2>Specializations</h2>
        <a href="#"><h3>IT</h3></a>
        <a href="#"><h3>Databases</h3></a>
        <a href="#"><h3>Graphic & Design</h3></a>
        <a href="#"><h3>Games</h3></a>
        <a href="#"><h3>Mobile technologies</h3></a>
        <a href="#"><h3>More...</h3></a>
    </div>
</div>
<div class="rightMainCol">
    <%
        for (int i = 1; i < n; i++){
    %>
    <div id="courseCard">
        <div class="leftPart">
            <img src="image/teacher-icon.png" alt="">
            <h4><%=request.getAttribute("course_lecturer"+n)%></h4>
        </div>

        <div class="centerPart">
            <h2 id="courseNameAndDescr"><%=request.getAttribute("course_name"+n)%> : <%=request.getAttribute("course_theme"+n)%></h2>
            <span>Description: </span><span><%=request.getAttribute("course_description"+n)%>
            </span>
            <br/>
            <div id="lessCount">
                <span><h4>Lessons: </h4></span>
                <span><h4><%=request.getAttribute("course_less_count"+n)%></h4></span>
            </div>
        </div>

        <div class="rightPart">
            <div id="rate">
                <div class="starsRate">
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                </div>
                <h4 id="voice">100 voices</h4>
            </div>
            <button id="showMoreButt" type="button" name="button">Show more</button>
        </div>
    </div>
    <%
        }
    %>

    <!--<div id="courseCard">
        <div class="leftPart">
            <img src="image/teacher-icon.png" alt="">
            <h4>Name</h4>
        </div>

        <div class="centerPart">
            <h2 id="courseNameAndDescr">Course theme: short description</h2>
            <span>Description: </span><span>Lorem ipsum dolor sit amet, consectetur
              adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
              magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
              nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
              voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
              cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
            </span>
            <br/>
            <div id="lessCount">
                <span><h4>Lessons: </h4></span>
                <span><h4>12</h4></span>
            </div>
        </div>

        <div class="rightPart">
            <div id="rate">
                <div class="starsRate">
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                </div>
                <h4 id="voice">100 voices</h4>
            </div>
            <button id="showMoreButt" type="button" name="button">Show more</button>
        </div>
    </div>

    <div id="courseCard">
        <div class="leftPart">
            <img src="image/teacher-icon.png" alt="">
            <h4>Name</h4>
        </div>

        <div class="centerPart">
            <h2 id="courseNameAndDescr">Course theme: short description</h2>
            <span>Description: </span><span>Lorem ipsum dolor sit amet, consectetur
              adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore
              magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
              nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
              voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat
              cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum
            </span>
            <br/>
            <div id="lessCount">
                <span><h4>Lessons: </h4></span>
                <span><h4>12</h4></span>
            </div>
        </div>

        <div class="rightPart">
            <div id="rate">
                <div class="starsRate">
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                    <span>&#9734;</span>
                </div>
                <h4 id="voice">100 voices</h4>
            </div>
            <button id="showMoreButt" type="button" name="button">Show more</button>
        </div>
    </div>
-->
</div>
</body>
</html>
