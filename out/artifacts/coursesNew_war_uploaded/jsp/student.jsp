<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<html>
<head>
    <meta charset="utf-8">
    <title>Student</title>
    <link rel="stylesheet" type="text/css" href="css/lecturer.css">
</head>
<body>

<%
    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

   // request.setParameter("student", "student");
    String student = session.getAttribute("name").toString(); //request.getAttribute("lecturer");

    try {
        pst = conn.prepareStatement("SELECT user_name, description FROM user WHERE login = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, student);

    ResultSet rs = pst.executeQuery();
    if(rs.next()){
        if (rs.getString("user_name") != null)
            request.setAttribute("student_name", rs.getString("user_name"));
        else
            request.setAttribute("student_name", "");
        if (rs.getString("description") != null)
            request.setAttribute("student_description", rs.getString("description"));
        else
            request.setAttribute("student_description", "");
    }

    try {
        pst = conn.prepareStatement("SELECT course.id, course.course_name, course.description, subscribe.mark FROM courses.subscribe, courses.user, courses.course " +
                "where (user.login = subscribe.student) and (course.id = subscribe.course) and (user.login = ?)");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, student);

    rs = pst.executeQuery();

    int n = 1;
    while(rs.next()){
        request.setAttribute("course_id"+n, rs.getString("id"));
        if (rs.getString("course_name") != null)
            request.setAttribute("course_name"+n, rs.getString("course_name"));
        else
            request.setAttribute("course_name"+n, "");
        if (rs.getString("description") != null)
            request.setAttribute("course_description"+n, rs.getString("description"));
        else
            request.setAttribute("description"+n, "");
        if (rs.getString("mark") != null)
            request.setAttribute("course_mark"+n, rs.getInt("mark"));
        else
            request.setAttribute("course_mark"+n, "");
        n++;
    }
%>

<jsp:include page="header/header.jsp"/>

<div class="title">Student Page</div>
  <div class="content">
    <div class="lecturer">
      <h3><p align="center"><%=request.getAttribute("student_name")%></p></h3>
        <h4><p align="center">student</p></h4>
        <div id="personal_info">
            <div class="lecturer_info" >
              <details>
                <summary>Personal information</summary>
                <p id="persinfo"><%=request.getAttribute("student_description")%></p>
              </details>
            </div>
        </div>
      </div>
      <div class = "course_column">

          <div class="courses_info">
              <div class="hdr">My courses</div><br/>
              <div class="courseH">In process:</div>
        <%
            for (int i = 1; i < n; i++)
                if (request.getAttribute("course_mark"+i).equals("")){
        %>
        <div class="course">
          <h4><a href="course.jsp?course_id=<%=request.getAttribute("course_id"+i)%>"><%=request.getAttribute("course_name"+i)%></a></h4>
          <button id="butCheck" onclick="pageRedirect('unsubscribeprocess.jsp?course_id=<%=request.getAttribute("course_id"+i)%>')">Unsubscribe</button>
        </div>
        <%
                }
        %>
              <div class="courseH">Complited: </div>
        <%
            for (int i = 1; i < n; i++)
                if (!request.getAttribute("course_mark"+i).equals("")){
        %>
        <div class="course" >
            <h4><a href="'course.jsp?course_id=<%=request.getAttribute("course_id"+i)%>'"><%=request.getAttribute("course_name"+i)%></a></h4>
            <div id="mark"><h4>Mark: <%=request.getAttribute("course_mark"+i)%></h4></div>
        </div>
        <%
                }
        %>

    </div>
</div>
</body>
</html>
