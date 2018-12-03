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
    String c_id = request.getParameter("course_id");
    String l_id = request.getParameter("lesson_id");
    System.out.println("id: " + l_id);

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
    }


    String test_id = request.getParameter("test_id");

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
%>
<div class="main_layer">
    <div class="title" id="course_title"><%=cn%></div>
    <hr>

    <div class="leftcol">
        <button class="button" id="button_main" onclick="save_test();">Save Test</button>
        <button class="button" id="button_main" onclick="add_close();">+ Add close question</button>
        <button class="button" id="button_main" onclick="add_open();">+ Add open question</button>
    </div>
    <%System.out.println("id: " + l_id);%>
    <form class = "rightcol" id="rightcol_id" action="addtestprocess.jsp">
        <div class="material_title" data-medium-editor-element="true">Questions</div>
        <div class="edit_test" id="edit_test_id" name="test">
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
         </div>
        <input type="text" name="course_id" id="course_id" value="<%=c_id%>" style="display:none;"/>
        <input type="text" name="lesson_id" id="lesson_id" value="<%=l_id%>" style="display:none;"/>
        <input type="text" name="quest_count" id="quest_count_id" style="display:none;"/>
    </form>
</div>
<br>
</body>
</html>
