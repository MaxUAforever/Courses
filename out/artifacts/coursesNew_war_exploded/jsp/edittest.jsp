<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Header part</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/addtest.css">
    <script src="js/edittest.js"></script>
</head>
<body>
<jsp:include page="header/header.jsp"/>
<%
    String test_id = request.getParameter("test_id");

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT course.id as course_id, course_name, lesson.id as lesson_id, test.isExam FROM `course` LEFT JOIN (lesson LEFT JOIN test ON test.lesson = lesson.id) ON lesson.course = course.id WHERE test.id=?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);

    String cn = "";
    String c_id = "";
    String l_id = null;
    String isExam = null;
    ResultSet rs = pst.executeQuery();
    if(rs.next()) {
        c_id = rs.getString("course_id");
        cn = rs.getString("course_name");
        isExam = rs.getString("isExam");
        if(isExam.equals("0")) {
            l_id = rs.getString("lesson_id");
        }
    }

    try {
        pst = conn.prepareStatement("SELECT id, q_text, points, isOpen FROM question WHERE test = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);

    rs = pst.executeQuery();
    int n = 1;
    while(rs.next()) {
        request.setAttribute("quest_id" + n, rs.getString("id"));
        request.setAttribute("quest_text" + n, rs.getString("q_text"));
        request.setAttribute("quest_points" + n, rs.getString("points"));
        request.setAttribute("quest_isOpen" + n, rs.getString("isOpen"));
        String isOpen = request.getAttribute("quest_isOpen"+n).toString();
        if(isOpen.equals("0")){
            PreparedStatement pst2 = null;
            try {
                pst2 = conn.prepareStatement("SELECT id, a_text, coefficient FROM answer WHERE question = ?");
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
                request.setAttribute(a + "ans_coef" + n, rs2.getString("coefficient"));
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
        <button class="button" id="button_main" onclick="add_close();">+ Add close question</button>
        <button class="button" id="button_main" onclick="add_open();">+ Add open question</button>
    </div>
    <form class = "rightcol" id="rightcol_id" action="addtestprocess.jsp">
        <div class="material_title" data-medium-editor-element="true">Questions</div>
        <input type="text" name="q_cnt" id="q_cnt" value="<%=n-1%>" style="display:none;"/>
        <%
            for(int i=1; i < n; i++){
                System.out.println(request.getAttribute("quest_text"+i));
                int isOpen = Integer.parseInt(request.getAttribute("quest_isOpen"+i).toString());
                if(isOpen == 0){%>
        <div class="edit_test" id="edit_test_id" name="test<%=i%>">
            <label class="lbl">Number of answers (2-10):</label>
            <input type="number" id="number_id" value="<%=request.getAttribute("count"+i)%>" min="2" max="10" onchange="add_answers(this);"/>
            <label class="lbl">Mark for question:</label>
            <input type="number" id="mark_id" name="mark<%=i-1%>" value="<%=request.getAttribute("quest_points"+i)%>" min="0"/>
            <div class="question" id = "question_id" name="quest<%=i-1%>" contenteditable="true"
                 spellcheck="true" data-medium-editor-element="true" role="textbox" aria-multiline="true"><%=request.getAttribute("quest_text"+i)%></div>

            <% System.out.println("A: " + request.getAttribute("count"+i));
                int count = Integer.parseInt(request.getAttribute("count"+i).toString());
            %>
            <input type="text" name="ans_cnt<%=i-1%>" id="ans_cnt" value="<%=count-1%>" style="display:none;"/>
            <%
                for(int j = 1; j < count; j++){%>
            <div class="answer" id = "answer_id" name="<%=j-1%>ans<%=i-1%>" contenteditable="true"
                 spellcheck="true" data-medium-editor-element="true" role="textbox" aria-multiline="true"><%=request.getAttribute(j+"ans_text"+i)%></div>

            <label class="lbl">Mark for answer:</label>
            <input type="number" id="mark_id" name="<%=j-1%>coef<%=i-1%>" value="<%=request.getAttribute(j+"ans_coef"+i)%>" min="0"/>

            <%}%>

        </div>

        <%}
        else{%>
        <div class="edit_open" id = "edit_open_id">
            <div class="question" id = "question_id" name="quest<%=i-1%>" contenteditable="true"
                 spellcheck="true" data-medium-editor-element="true" role="textbox" aria-multiline="true"><%=request.getAttribute("quest_text"+i)%></div>

            <label class="lbl">Mark for question:</label>
            <input type="number" id="mark_id" name="mark<%=i-1%>" value="<%=request.getAttribute("quest_points"+i)%>" min="1"/>
        </div>
        <%}
        }%>
        <br>
        <button class="button" type="button" id="button_main" onclick="save_test();">Save Test</button>
        <button class="button" type="button" id="button_main" onclick="openPopUpConf()">Cancel</button>


        <input type="text" name="test_id" id="test_id" value="<%=test_id%>" style="display:none;"/>
        <input type="text" name="course_id" id="course_id" value="<%=c_id%>" style="display:none;"/>
        <input type="text" name="lesson_id" id="lesson_id" value="<%=l_id%>" style="display:none;"/>
        <input type="text" name="quest_count" id="quest_count_id" style="display:none;"/>

        <%
            for(int i=1; i < n; i++){ %>
        <textarea name="quest<%=i-1%>" class="question_area" id="quest<%=i-1%>" style="display:none;"></textarea>
        <% int isOpen = Integer.parseInt(request.getAttribute("quest_isOpen"+i).toString());
            if(isOpen == 0){
                int count = Integer.parseInt(request.getAttribute("count"+i).toString());
                for(int j = 1; j < count; j++){%>
        <textarea name="<%=j-1%>ans<%=i-1%>" class="answer_area" id="ans<%=i-1%>" style="display:none;"></textarea>
        <%}
        }
        }%>
    </form>

    <div class="popupconfcont" id="popupconfcont">
        <div class="popupconf" id="popupconf">
            <div class="operstatus">All changes will be lost. Continue?</div>
            <div class="popUpButtons">
                <button id="confirm" onclick="statusPressed('confirm');closePopUpConf();pageRedirect('course.jsp?course_id=<%=c_id%>')">OK</button>
                <button id="cancel" onclick="statusPressed('close');closePopUpConf()">Cancel</button>
            </div>
        </div>
    </div>
</div>
<br>

</body>
</html>
