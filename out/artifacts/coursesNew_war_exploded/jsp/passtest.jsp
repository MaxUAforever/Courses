<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>

<!DOCTYPE html>
<html>
<head>
    <title>Test</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/test.css">
</head>
<body>
<%
    //request.setAttribute("course_id", "4");
    String test_id = request.getParameter("test_id");
    //System.out.println(request == null);

    //session.setAttribute("name", "student");
    String user = session.getAttribute("name").toString();

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT lesson.id FROM lesson INNER JOIN test ON test.lesson = lesson.id WHERE test.id = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);

    ResultSet rs = pst.executeQuery();

    String less_id = "";
    if(rs.next()){
        less_id = rs.getString("id");
    }

    try {
        pst = conn.prepareStatement("INSERT INTO studentlesson(student, lesson, page, mark) VALUES(?, ?, null, null)");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }
    pst.setString(1, user);
    pst.setString(2, less_id);

    pst.executeUpdate();

    try {
        pst = conn.prepareStatement("SELECT id, q_text, isOpen FROM question WHERE test = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);

    rs = pst.executeQuery();
    int n = 1;
    while(rs.next()) {
        request.setAttribute("quest_id" + n, rs.getString("id"));
        request.setAttribute("quest_text" + n, rs.getString("q_text"));
        request.setAttribute("quest_isOpen" + n, rs.getString("isOpen"));
        String isOpen = request.getAttribute("quest_isOpen"+n).toString();
        if(isOpen.equals("0")){
            PreparedStatement pst2 = null;
            try {
                pst2 = conn.prepareStatement("SELECT id, a_text FROM answer WHERE question = ?");
            } catch (SQLException e) {
                out.println("SQL query creating error");
            }
            String question = request.getAttribute("quest_id"+n).toString();
            pst2.setString(1, question);

            ResultSet rs2 = pst2.executeQuery();
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
    //String isOpen = request.getAttribute("quest_isOpen" + 1);
    //System.out.println(isOpen);
%>
<!--<h3><span>-</span><a href="#"></a></h3>
<h3><span>-</span><a href="#">Lecture 2</a></h3>
<h3><span>-</span><a href="#">Lecture 3</a></h3>
-->
<%

    //response.sendRedirect("course.jsp");
%>
<jsp:include page="header/header.jsp"/>
<center><b><h2>Test</h2></b></center>
<div class="content" id="content">
    <form action="fillanswers.jsp?course_id=<%=course_id%>&test_id=<%=test_id%>" method="post" name="test">
        <div class = "testQuestion">
            <ol>
                <%
                    for (int i = 1; i < n; i++){
                        String isOpen = request.getAttribute("quest_isOpen"+i).toString();
                        if((isOpen.equals("0"))){
                %>
                <li><b> Question <%=i%>. <%=request.getAttribute("quest_text"+i)%> </b><br/>
                    <div class="answers">
                        <%
                            String countS = request.getAttribute("count" + i).toString();
                            int count = Integer.parseInt(countS);
                            for (int j = 1; j < count; j++){%>
                        <input type="radio" name="ans<%=i%>" value="<%=request.getAttribute(j +"ans_id"+i)%>"/> <%=request.getAttribute(j +"ans_text"+i)%><br />
                        <%}%>
                    </div>
                    <br/></li>
                <%}
                else{
                %>
                <li><div class="textQuestion">
                    <b>Question <%=i%>. <%=request.getAttribute("quest_text"+i)%></b><br/>
                    <TEXTAREA name="ans<%=i%>" rows="4" cols="118"> </TEXTAREA>
                </div></li>
            <%
                    }}
            %>
            </ol>
        </div>
        <CENTER>
            <button type="submit">Send answers</button>
        </CENTER>
    </form>
</div>
<footer class="foot" id="footer">
    <div class="footcont">
        <div class="contact">
            <p><strong>Contacts:</strong>     maxuaforever@gmail.com</p>
            <div class="copyright">
                <p>&copy 2009 - 2018 All rights reserved</p>
            </div>
        </div>
    </div>
</footer>

<!--<div class="popupans" id="popupans">
    <div class="popupanswer" id="popupanswer">
        <div class="operstatus">Course will be deleted. Continue?</div>
        <div class="popUpButtons">
            <button id="confirm" onclick="statusPressed('confirm');closePopUpConf();">OK</button>
            <button id="cancel" onclick="statusPressed('close');closePopUpConf()">Cancel</button>
        </div>
    </div>
</div>-->

</body>


<!-- Test created by service http://test.fromgomel.com -->
