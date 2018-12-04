<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<html>
  <head>
    <meta charset="utf-8">
    <title>Students</title>
    <link rel="stylesheet" href="css/list_of_students.css">
  </head>
  <body>
  <div>
      <jsp:include page="header/header.jsp"/>
  </div>

  <%
      Class.forName("com.mysql.jdbc.Driver");

      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
      PreparedStatement pst = null;

      //setAttribute("lecturer", "lecturer");
      String lecturer = session.getAttribute("name").toString(); //request.getAttribute("lecturer");

      try {
          pst = conn.prepareStatement("SELECT user.login, user.user_name FROM courses.user, courses.subscribe\n" +
                  "WHERE (subscribe.student = user.login) and subscribe.course = (\n" +
                  "\n" +
                  "SELECT course.id FROM courses.user, courses.course\n" +
                  "WHERE (user.login = ?) and (user.login = course.lecturer));");
      } catch (SQLException e) {
          out.println("SQL query creating error");
      }

      pst.setString(1, lecturer);

      ResultSet rs = pst.executeQuery();

      int n = 1;
      while(rs.next()){
          request.setAttribute("student_login"+n, rs.getString("login"));
          request.setAttribute("student_name"+n, rs.getString("user_name"));
          n++;
      }
  %>

    <h3 id="listTitle">List of students</h3>
    <ol>
        <%
            for (int i = 1; i < n; i++){
        %>
        <li><a id="studentName" href="#"><%= request.getAttribute("student_name"+i)%></a></li>
        <%
            }
        %>
    </ol>
  <div>
      <jsp:include page="footer/footer.html"/>
  </div>
  </body>
</html>
