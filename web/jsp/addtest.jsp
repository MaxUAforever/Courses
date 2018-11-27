<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Header part</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/addtest.css">
    <script src="js/addtest.js"></script>
</head>
<body>
<jsp:include page="header/header.jsp"/>
<%
    String c_id = "1";//request.getParameter("course_id");

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT course_name FROM `course` WHERE id=?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, c_id);

    String cn = "";

    ResultSet rs = pst.executeQuery();
    if(rs.next()) {
        cn = rs.getString("course_name");
        //request.setAttribute("course_name", rs.getString("course_name"));
    }
%>
<div class="main_layer">
    <div class="title" id="course_title"><%=cn%></div>
    <hr>

    <div class="leftcol">
        <button class="button" id="button_main" onclick="save_test();">Save Test</button>
        <button class="button" id="button_main" onclick="add_close();">+ Add close question</button>
        <button class="button" id="button_main" onclick="add_open();">+ Add open question</button>
    </div>
    <form class = "rightcol" id="rightcol_id" action="addtestprocess.jsp">
        <div class="material_title" data-medium-editor-element="true">Questions</div>
       <!-- <div class="edit_test" id="edit_test_id" name="test">
            <label class="lbl">Number of answers (2-10):</label>
            <input type="number" id="number_id" value="2" min="2" max="10" onchange="add_answers(this);"/>
            <label class="lbl">Mark for question:</label>
            <input type="number" id="mark_id" value="1" min="0"/>
            <div class="question" id = "question_id" contenteditable="true" data-placeholder="Enter question..."
                 spellcheck="true" data-medium-editor-element="true" role="textbox" aria-multiline="true"></div>
            <div class="answer" id = "answer_id" contenteditable="true" data-placeholder="Enter answer..."
                 spellcheck="true" data-medium-editor-element="true" role="textbox" aria-multiline="true"></div>
            <label class="lbl">Mark for answer:</label>
            <input type="number" id="mark_id" value="0" min="0"/>
            <div class="answer" id = "answer_id" contenteditable="true" data-placeholder="Enter answer..."
                 spellcheck="true" data-medium-editor-element="true" role="textbox" aria-multiline="true"></div>
            <label class="lbl">Mark for answer:</label>
            <input type="number" id="mark_id" value="1" min="0"/>
            <label class="lbl">Mark for question:</label>
            <input type="number" id="number_id" value="1" min="1"/>
        </div>

        <div class="edit_open" id = "edit_open_id">
            <div class="question" id = "question_id" contenteditable="true" data-placeholder="Enter open question..."
                 spellcheck="true" data-medium-editor-element="true" role="textbox" aria-multiline="true"></div>
            <label class="lbl">Mark for question:</label>
            <input type="number" id="mark_id" value="1" min="1"/>
        </div>-->
    </form>
</div>

</body>
</html>




