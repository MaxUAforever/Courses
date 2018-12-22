<%--
  Created by IntelliJ IDEA.
  User: User646
  Date: 26.11.2018
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Test Results</title>
    <link rel="stylesheet" href="css/test_check.css">
    <script type="text/javascript" src="js/test_check.js">
    </script>
</head>
<body>
<div>
    <jsp:include page="header/header.jsp"/>
</div>

<%
    String test_id = request.getParameter("test_id");
    String student = request.getParameter("student");

    System.out.println("student: " + student + "test: " + test_id);

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT id, q_text, points, isOpen FROM question WHERE test = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);

    ResultSet rs = pst.executeQuery();
    int n = 1;
    while(rs.next()) {
        request.setAttribute("quest_id" + n, rs.getString("id"));
        request.setAttribute("quest_text" + n, rs.getString("q_text"));
        request.setAttribute("quest_points" + n, rs.getString("points"));
        request.setAttribute("quest_isOpen" + n, rs.getString("isOpen"));

        PreparedStatement pst2 = null;
        try {
            pst2 = conn.prepareStatement("SELECT answer.id, a_text, coefficient FROM (studentanswer INNER JOIN (answer INNER JOIN (question INNER JOIN test ON question.test = test.id) ON answer.question = question.id) ON answer.id = studentanswer.answer) WHERE (studentanswer.student = ?) AND question.id = ?");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        String question = request.getAttribute("quest_id"+n).toString();
        pst2.setString(1, student);
        pst2.setString(2, question);

        ResultSet rs2 = pst2.executeQuery();
        if (rs2.next()) {
            request.setAttribute("ans_stud_id" + n, rs2.getString("id"));
            request.setAttribute("ans_stud_text" + n, rs2.getString("a_text"));
            request.setAttribute("ans_stud_eval" + n, rs2.getString("coefficient"));
        }

        String isOpen = request.getAttribute("quest_isOpen"+n).toString();
        if(isOpen.equals("0")){
            int points = Integer.parseInt(rs.getString("points"));
            double coefficient = Double.parseDouble(rs2.getString("coefficient"));
            request.setAttribute("ans_stud_eval" + n, coefficient*points);

            try {
                pst2 = conn.prepareStatement("SELECT id, a_text FROM answer WHERE question = ?");
            } catch (SQLException e) {
                out.println("SQL query creating error");
            }
            /*String */question = request.getAttribute("quest_id"+n).toString();
            pst2.setString(1, question);

            /*ResultSet */rs2 = pst2.executeQuery();
            int a = 1;
            while (rs2.next()) {
                request.setAttribute(a + "ans_id" + n, rs2.getString("id"));
                request.setAttribute(a + "ans_text" + n, rs2.getString("a_text"));
                a++;
            }
            request.setAttribute("count" + n, a);
        }
        n++;
    }

    try {
        pst = conn.prepareStatement("SELECT course.id FROM (course INNER JOIN (lesson INNER JOIN test ON lesson.id = test.lesson) ON course.id = lesson.course) WHERE test.id = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);

    rs = pst.executeQuery();

    String course_id = "1";
    if(rs.next()) {
        course_id = rs.getString("id");

    }
%>

<form class="testQuestForm" action="markanswers.jsp?course_id=<%=course_id%>&test_id=<%=test_id%>" method="post">
    <h3>Results of Test</h3>
    <%
        for (int i = 1; i < n; i++){
            String isOpen = request.getAttribute("quest_isOpen"+i).toString();
            if((isOpen.equals("0"))){
    %>
        <div class="testQuest">
        <span class="quest">
          <p class="questP">
            Question <%=i%>. <%=request.getAttribute("quest_text"+i)%>
          </p>
        </span>
        <div class="testQuestAns">
            <%
                String countS = request.getAttribute("count" + i).toString();
                int count = Integer.parseInt(countS);
                for (int j = 1; j < count; j++){%>
            <p <% if(request.getAttribute(j +"ans_text"+i).toString().equals(request.getAttribute("ans_stud_text" + i).toString())){%>style="text-decoration:underline"<%}%>><%=request.getAttribute(j +"ans_text"+i)%></p>
            <%}%>
            <input type="text" value="<%=request.getAttribute("ans_stud_eval" + i)%>" readonly>
        </div>
    </div>

    <%
            }
    else{
    %>

    <div class="openQuest">
    <span class="questP">
          <p class="questP">
            Question <%=i%>. <%=request.getAttribute("quest_text"+i)%>
          </p>
        </span>
    <div class="openQuestAns">
        <textarea name="name" rows="10" cols="80" readonly><%=request.getAttribute("ans_stud_text" + i)%></textarea>
    </div>
    <div class="openQuestMark">
        <p>Grade for answer:</p>
        <input type="text" name="ans<%=request.getAttribute("ans_stud_id"+i)%>">
    </div>
    </div>

        <%}
    }%>


    <button type="submit" name="button" ><!--onclick="openPopUpConf()"-->Grade</button>

    <div class="popupconfcont" id="popupconfcont">
        <div class="popupconf" id="popupconf">
            <div class="operstatus">Confirm changes?</div>
            <div class="popUpButtons">
                <button type="submit" id="confirm" onclick="statusPressed('confirm');closePopUpConf(); pageRedirect()">OK</button>
                <button id="cancel" onclick="statusPressed('cancel');closePopUpConf()">Cancel</button>
            </div>
        </div>
    </div>

</form>
</body>
</html>

