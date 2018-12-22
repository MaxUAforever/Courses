<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Main page</title>
    <link rel="stylesheet" href="css/page_with_courses.css">
    <script src="js/allcourses.js"></script>
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
<%
    //request.setAttribute("course_id", "4");
    //String course_id = "1";

    String theme = null;
    if (request.getParameter("theme") != null)
        theme = request.getParameter("theme");

    String search = null;
    if (request.getParameter("q") != null)
        search = request.getParameter("q");
    System.out.println("Search: " + search);

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    if ((theme == null) && (search == null)){
        try {
            pst = conn.prepareStatement("SELECT course.id, course.lecturer, course.course_name, course.theme, course.description, COUNT(subscribe.id) AS sub_count FROM course LEFT JOIN subscribe ON course.id = subscribe.course GROUP BY course.id");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
    }
    else if (search != null){
        System.out.println("Meow tut ");
        try {
            pst = conn.prepareStatement("SELECT course.id, course.lecturer, course.course_name, course.theme, course.description, COUNT(subscribe.id) AS sub_count FROM course LEFT JOIN subscribe ON course.id = subscribe.course WHERE course.course_name LIKE \"%\" ? \"%\" GROUP BY course.id");
            pst.setString(1, search);
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
    }
    else {
        try {
            pst = conn.prepareStatement("SELECT course.id, course.lecturer, course.course_name, course.theme, course.description, COUNT(subscribe.id) AS sub_count FROM course LEFT JOIN subscribe ON course.id = subscribe.course WHERE course.theme = ? GROUP BY course.id");
            pst.setString(1, theme);
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
    }

    ResultSet rs = pst.executeQuery();
    int n = 1;
    while(rs.next()){
        request.setAttribute("course_id"+n, rs.getString("id"));
        request.setAttribute("course_lecturer"+n, rs.getString("lecturer"));
        request.setAttribute("course_name"+n, rs.getString("course_name"));
        request.setAttribute("course_theme"+n, rs.getString("theme"));
        request.setAttribute("course_description"+n, rs.getString("description"));
        request.setAttribute("course_sub_count"+n, rs.getString("sub_count"));
        n++;
    }

    try {
        pst = conn.prepareStatement("SELECT DISTINCT theme FROM course");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    rs = pst.executeQuery();
    int t = 1;
    while(rs.next()){
        if ((rs.getString("theme") != null) && (!rs.getString("theme").equals(""))){
            request.setAttribute("theme"+t, rs.getString("theme"));
            t++;}
    }
%>

<div class="content">

    <div class="leftMainCol">

        <div id="specs">
            <h2>Specializations</h2>
            <%
                for (int i = 1; i < t; i++){
            %>
            <a href="allcourses.jsp?theme=<%=request.getAttribute("theme"+i)%>"><h3><%=request.getAttribute("theme"+i)%></h3></a>
            <%
                }
            %>
        </div>
    </div>

    <div class="rightMainCol">
        <%
            for (int i = 1; i < n; i++){
        %>
        <div id="courseCard">
            <div class="centerPart">
                <h2 id="courseNameAndDescr"><%=request.getAttribute("course_name"+i)%> : <%=request.getAttribute("course_theme"+i)%></h2>
                <div id="descr"> Description:&nbsp;<%=request.getAttribute("course_description"+i)%>
                </div>
                <br/>

                <div class="lectAuthor">
                    <h4>Lecturer:&nbsp;<%=request.getAttribute("course_lecturer"+i)%></h4></h4>
                </div>
            </div>

            <div class="rightPart">
                <div id="rate">
                    <div id="voice"><%=request.getAttribute("course_sub_count"+i)%> subscribers</div>
                </div>
            </div>
            <div class = "pageButt">
                <button id="showMoreButt"  onclick="pageRedirect('course.jsp?course_id=<%=request.getAttribute("course_id"+i)%>')" type="button"  name="button">Show More</button>
            </div>
        </div>
        <%
            }
        %>

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
    </div>
</div>
</body>
</html>
