<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<html>
<head>
    <title>Header part</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/addlecture.css">
    <script src="js/addlecture.js"></script>
</head>
<body>

<%
    String l_id = request.getParameter("lesson_id");

    try {
        Class.forName("com.mysql.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        out.println("Class exception");
    }

    Connection conn = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    } catch (SQLException e) {
        out.println("Connect error");
    }
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT lesson.id, course.course_name, lesson.less_name, lesson.description, lesson.material FROM course, lesson WHERE (lesson.course = course.id) AND (lesson.id = ?)");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, request.getParameter("lecture_id").toString());

    ResultSet rs = pst.executeQuery();

    rs.next();

    request.setAttribute("lecture_id", rs.getString("id"));
    if (rs.getString("course_name") != null)
        request.setAttribute("course_name", rs.getString("course_name"));
    else
        request.setAttribute("course_name", "");
    if (rs.getString("less_name") != null)
        request.setAttribute("lesson_name", rs.getString("less_name"));
    else
        request.setAttribute("lesson_name", "");
    if (rs.getString("description") != null)
        request.setAttribute("lesson_description", rs.getString("description"));
    else
        request.setAttribute("lesson_description", "");
    if (rs.getString("material") != null)
        request.setAttribute("lesson_material", rs.getString("material"));
    else
        request.setAttribute("lesson_material", "");
%>

<div class="main_layer">
    <div class="title" id="course_title"><%=request.getAttribute("course_name")%></div>
    <hr>

    <!-- <div class="leftcol"> -->
        <!-- <button class="button" id="button_main" onclick="save_lecture();">Save lecture</button> -->
        <!-- <button class="button" id="button_main" onclick="add_input();">+ Add text</button> -->
        <!-- <button class="button" id="button_main" onclick="add_photo();">+ Add picture</button> -->
    <!-- </div> -->
    <!-- <div class = "rightcol" id="rightcol_id"> -->
        <div class="edit_input_title" id="edit_input_title_id" contenteditable="true" data-placeholder="Enter lecture title..." spellcheck="true"
             data-medium-editor-element="true" role="textbox"><%=request.getAttribute("lesson_name")%></div>
        <textarea class="edit_description" id = "edit_description_id" rows="5" cols="80" placeholder="Add description"><%=request.getAttribute("lesson_description")%></textarea>
        <!-- <div class="edit_description" id = "edit_description_id" name="editable_desc" contenteditable="true" data-placeholder="Enter description..." spellcheck="true"
             data-medium-editor-element="true" role="textbox" aria-multiline="true"></div> -->
        <div class="material_title" data-medium-editor-element="true">Lecture material</div>
        <textarea class="edit_input_text" id = "edit_input_text" rows="10" cols="80" placeholder="Add lecture"><%=request.getAttribute("lesson_material")%></textarea>
        <!-- <div class="edit_input_text" id = "edit_input_text" name="editable_input" contenteditable="true" data-placeholder="Enter text..." spellcheck="true"
             data-medium-editor-element="true" role="textbox" aria-multiline="true"></div>
       <!-- <div class="input_photo" id="input_photo_id">
            <input type='file' id="upload" onchange="readURL(this);"/>
            <img src="#" id="upload-img" alt="image" />
        </div> -->
    <!-- </div> -->
    <button class="button" id="button_main" onclick="save_lecture();">Save lecture</button>
</div>
<form method="post" id="data_send" action="editlectureconfirm.jsp?lesson_id=<%=l_id%>">
    <input type="hidden" id="course_title_form" name="course_title" value="">
    <input type="hidden" id="lecture_title_form" name="lecture_title" value="">
    <input type="hidden" id="description_form" name="description" value="">
    <input type="hidden" id="text_form" name="text" value="">
</form>
</body>
</html>

