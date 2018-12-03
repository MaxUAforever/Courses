<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
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
    session.setAttribute("name", "lecturer");
    //request.setAttribute("course_id", "4");
    String course_id = request.getParameter("course_id");

    String edit = "false";
    if ((request != null) && (request.getAttribute("edit") != null))
        edit = request.getAttribute("edit").toString();

    if ((request != null) && (request.getParameter("textMsg") != null)){
        if (request.getParameter("textMsg").equals("1"))
            request.setAttribute("textMsg", "Lecture deleted!");
        else
            request.setAttribute("textMsg", "Invalid lecture credentials!");
    }
    String user = session.getAttribute("name").toString();

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT course_name, lecturer, theme, description FROM course WHERE id=?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, course_id);

    ResultSet rs = pst.executeQuery();
    if(rs.next()){
        request.setAttribute("course_name", rs.getString("course_name"));
        request.setAttribute("course_lecturer", rs.getString("lecturer"));
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
        PreparedStatement pst2 = null;
        try {
            pst2 = conn.prepareStatement("SELECT test.id FROM (lesson INNER JOIN test ON lesson.id = test.lesson) WHERE lesson.id = ?");
        } catch (SQLException e) {
        }
        String less_id =  request.getAttribute("less_id"+n).toString();
        pst2.setString(1, less_id);
        ResultSet rs2 = pst2.executeQuery();
        request.setAttribute("less_test"+n, null);
        if(rs2.next()) {
            request.setAttribute("less_test"+n, rs2.getString("id"));
        }
        n++;
        %>
        <!--<h3><span>-</span><a href="#"></a></h3>
        <h3><span>-</span><a href="#">Lecture 2</a></h3>
        <h3><span>-</span><a href="#">Lecture 3</a></h3>
        -->
        <%
    }

    try {
        pst = conn.prepareStatement("SELECT MAX(lesson.id) AS current FROM studentlesson INNER JOIN (lesson INNER JOIN course ON course.id = lesson.course) ON studentlesson.lesson = lesson.id WHERE student = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

            pst.setString(1, user);

            rs = pst.executeQuery();
            request.setAttribute("current_test", null);
            if(rs.next()) {
                request.setAttribute("current_test", rs.getInt("current"));
            }
    //response.sendRedirect("course.jsp");
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
        <h3><span>-</span><a class="lecture_link" href="#">Lecture <%=i%></a></h3>
        <!--<h3><span>-</span><a href="#">Lecture 2</a></h3>
        <h3><span>-</span><a href="#">Lecture 3</a></h3>-->
        <%
            }
        %>
    </div>
    <%if (user.equals(request.getAttribute("course_lecturer"))){
        System.out.println(user.equals(request.getAttribute("course_lecturer"))+" "+user+" "+request.getAttribute("course_lecturer"));%>
    <div id="addLect">
        <button type="button" name="button" onclick="pageRedirect('addlecture.jsp?course_id=<%=course_id%>')">Add lecture</button>
    </div>
    <div id="addExam">
        <button type="button" onclick="pageRedirect('addtest.jsp?course_id=<%=course_id%>&edit=true')" name="button">Add exam</button>
    </div>
    <%}%>
</div>
<!-- End navigate block -->
<!-- main part -->
<div class="rightCol">
    <div id="courseInfo">
        <h2 id="courseInfoTitle" <%if (!edit.equals("false")){ %>contenteditable="true"<%}%>><%=request.getAttribute("course_name")%></h2>
        <div id="lecturerBlock">
            <h3 id="lecturer">Lecturer:</h3>
            <div id="lecturerOfCourse" <%if (!edit.equals("false")){ %>contenteditable="true"<%}%>><%=request.getAttribute("course_lecturer")%></div>
        </div>
        <div id="themeBlock">
            <h3 id="theme">Theme:</h3>
            <div id="themeOfCourse" <%if (!edit.equals("false")){ %>contenteditable="true"<%}%>><%=request.getAttribute("course_theme")%></div>
        </div>
        <h3 id="desc">Description:</h3>
        <div id="text">
            <p id="lorem" <%if (!edit.equals("false")){ %>contenteditable="true"<%}%>><%=request.getAttribute("course_description")%></p>
        </div>
        <%if (user.equals(request.getAttribute("course_lecturer"))){%>
        <div id="buttOfCourseInfo">
            <!--<form action="editsavecourse.jsp" method="post" class="courseedit">-->
            <!--<a href="editsavecourse.jsp?course_id=<%//=course_id%>&edit=<%//=edit%>">--><button type="button" onclick="call('<%=course_id%>', '<%=edit%>')" name="button"><%if (edit == "true"){%>Save<%} else{System.out.println("Meow " + edit);%>Edit<%}%></button><!--</a>-->
            <!--</form>-->
            <button type="button" onclick="openPopUpConf()" name="button">Delete</button>
        </div>
        <%}%>
    </div>

    <h2 id="lessonsTitle">Lessons</h2>

    <%
        boolean flag = false;
        if (request.getAttribute("current_test") == null)
            flag = true;

        for (int i = 1; i < n; i++){
    %>
    <div id="lectureInfo">
        <div id="lectureHead">
            <h5 id="lessonNum">Lecture <%=i%></h5>
            <%if (!user.equals(request.getAttribute("course_lecturer"))){%>
            <h3 id="lectureInfoTitle"><a class="lecture_link" href="lecture.jsp?lecture_id=<%=request.getAttribute("less_id"+i)%>"><%=request.getAttribute("less_name"+i)%></a></h3>
            <%}else {%>
            <h3 id="lectureInfoTitle"><a class="lecture_link" href="editlecture.jsp?course_id=<%=course_id%>&lecture_id=<%=request.getAttribute("less_id"+i)%>"><%=request.getAttribute("less_name"+i)%></a></h3>
            <%}%>
        </div>
        <div id="text">
            <p id="lorem"><%=request.getAttribute("less_description"+i)%></p>
        </div>
        <div id="bottom">
            <%if ((flag)&&(request.getAttribute("less_test"+i) != null)&&(!user.equals(request.getAttribute("course_lecturer"))))
                {%><h3><a id="testRef" href="passtest.jsp?test_id=<%=request.getAttribute("less_test"+i)%>">Test</a></h3><% flag = false;
            }else if (user.equals(request.getAttribute("course_lecturer"))){%><h3><a id="testRef" href="addtest.jsp?course_id=<%=course_id%>&lesson_id=<%=request.getAttribute("less_id"+i)%>">Add test</a></h3><%}%>
            <%if (user.equals(request.getAttribute("course_lecturer"))){%>
            <div id="buttOfLectureInfo">
                <button type="button" onclick="pageRedirect('editlecture.jsp?course_id=<%=course_id%>&lecture_id=<%=request.getAttribute("less_id"+i)%>')" name="button">Edit</button>
                <button type="button" onclick="openPopUpLess('<%=request.getAttribute("less_id"+i)%>')" name="button">Delete</button>
            </div>
            <%}%>
        </div>
    </div>
    <%
        if ((request.getAttribute("current_test") != null)&&(request.getAttribute("current_test").toString().equals(request.getAttribute("less_id"+i).toString())))
        flag = true;
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

    <div class="popupconfcont" id="popupconfcont">
        <div class="popupconf" id="popupconf">
            <div class="operstatus">Course will be deleted. Continue?</div>
            <div class="popUpButtons">
                <button id="confirm" onclick="statusPressed('confirm');closePopUpConf();pageRedirect('deletecourseprocess.jsp?course_id=<%=course_id%>')">OK</button>
                <button id="cancel" onclick="statusPressed('close');closePopUpConf()">Cancel</button>
            </div>
        </div>
    </div>

    <div class="popupconfless" id="popupconfless">
        <div class="popupless" id="popupless">
            <div class="operstatus">Lecture will be deleted. Continue?</div>
            <div class="popUpButtons">
                <button id="confirm" onclick="statusPressed('confirm');closePopUpLess();pageRedirectLecture('deletelectureprocess.jsp?lecture_id=')">OK</button>
                <button id="cancel" onclick="statusPressed('close');closePopUpLess()">Cancel</button>
            </div>
        </div>
    </div>

    <div class="popupcont" id="popupcont">
        <div class="popup" id="popup">
            <div class="operstatus"><%=request.getAttribute("textMsg")%></div>
            <button class="close" onclick="closePopUp()">OK</button>
        </div>
    </div>

    <% if (request != null && request.getAttribute("textMsg") != null)
    { %>
    <script type="text/javascript">
        openPopUp();
    </script>
        <% }

%>



</body>
</html>
