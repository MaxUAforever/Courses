<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Lecturer</title>
    <link rel="stylesheet" type="text/css" href="css/lecturertocheck.css">
  <script src="js/lecturertocheck.js"></script>
</head>
<body>
<%
  session.setAttribute("name", "lecturer");
  String lecturer = session.getAttribute("name").toString();
  System.out.println(lecturer);
  Class.forName("com.mysql.jdbc.Driver");

  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
  PreparedStatement pst = null;

  try {
    pst = conn.prepareStatement("SELECT DISTINCT student1.login, test.id, course.course_name, lesson.less_name FROM `user` AS lecturer INNER JOIN (course INNER JOIN ((lesson INNER JOIN (studentlesson INNER JOIN `user` AS student1 ON student1.login = studentlesson.student) ON studentlesson.lesson = lesson.id) INNER JOIN (test INNER JOIN (question INNER JOIN (answer INNER JOIN (studentanswer INNER JOIN `user` AS student2 ON studentanswer.student = student2.login) ON studentanswer.answer = answer.id) ON answer.question = question.id) ON question.test = test.id) ON test.lesson = lesson.id) ON course.id = lesson.course) WHERE lecturer.login = ? AND studentlesson.mark IS NULL AND student1.login = student2.login");
  } catch (SQLException e) {
    out.println("SQL query creating error");
  }

  pst.setString(1, lecturer);

  ResultSet rs = pst.executeQuery();
  int n = 1;
  while(rs.next()) {
    request.setAttribute("student"+n, rs.getString("login"));
    System.out.println(rs.getString("login"));
    request.setAttribute("test_id"+n, rs.getString("id"));
    request.setAttribute("course"+n, rs.getString("course_name"));
    request.setAttribute("lecture"+n, rs.getString("less_name"));
    n++;
  }
%>
  <div class="content">
    <div class="title">Test notifications</div>
      <div class="infocol">
        <p> Unchecked tests:</p><br>
        <%for (int i = 1; i < n; i++){%>
        <div class="testinfo">
          <div id="testText"><%=request.getAttribute("course"+i)%>: <%=request.getAttribute("student"+i)%> passed test from lesson <%=request.getAttribute("lecture"+i)%>.</div>
          <button id="butCheck" onclick="pageRedirect('testcheck.jsp?student=<%=request.getAttribute("student"+i)%>&test_id=<%=request.getAttribute("test_id"+i)%>')">Check</button>
        </div>
        <%}%>
    </div>
  </div>
</body>
