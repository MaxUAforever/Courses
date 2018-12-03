<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Course Title</title>
    <meta charset="utf-8">
    <link rel="stylesheet" type = "text/css" href="css/course.css">
    <script src="js/course.js"></script>
</head>
<body>
<jsp:include page="header/header.jsp"/>
<%
    /*Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;*/

    String user = "lecturer";//session.getAttribute("name").toString();
%>

<div id="coursetitle">
    <h1 id="title">Course information</h1>
    <div id="voiceBlock"></div>
    <!--<h4 id="voice">100 voices</h4>
        <span>&#9734;</span>
        <span>&#9734;</span>
        <span>&#9734;</span>
        <span>&#9734;</span>
        <span>&#9734;</span>
    </div>-->
</div>
<div id="titleLine">
    <hr align="center" width="95%" size="2" color="#000000" />
    <br />
</div>
<!-- End title block -->
<!-- Main block -->
<!-- navigate block -->
<div class="leftCol">
    <div id="navig">
        <h2 id="navTitle">Place for your education plan</h2>
    </div>
    <%System.out.println(user.equals(request.getAttribute("course_lecturer"))+" "+user+" "+request.getAttribute("course_lecturer"));%>
</div>
<!-- End navigate block -->
<!-- main part -->
<div class="rightCol">
    <div id="courseInfo">
        <h2 id="courseInfoTitle" contenteditable="true">Enter course title...</h2>
        <div id="themeBlock">
            <h3 id="theme">Theme:</h3>
            <div id="themeOfCourse" contenteditable="true">Enter your theme...</div>
        </div>
        <h3 id="desc">Description:</h3>
        <div id="text">
            <p id="lorem" contenteditable="true">Enter your description of course...</p>
        </div>

        <div id="buttOfCourseInfo">
            <button type="button" onclick="call();" name="button">Save</button>
            <button type="button" onclick="openPopUpConf();" name="button">Cancel</button>
        </div>
    </div>
    <h2 id="lessonsTitle">Place for your lectures</h2>
</div>

</body>
</html>
