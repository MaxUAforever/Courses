<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Header part</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/addlecture.css">
    <script src="js/addcourse.js"></script>
</head>
<body>
<jsp:include page="header/header.jsp"/>
<%
    /*String c_id = request.getParameter("course_id");

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT course_name FROM course WHERE id=?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, c_id);

    ResultSet rs = pst.executeQuery();
    if(rs.next()) {
        request.setAttribute("course_name", rs.getString("course_name"));
    }*/
%>
<div class="main_layer">
    <div class="title" id="course_title">New course</div>
    <hr>
    <div class="leftcol">
        <button class="button" id="button_main" onclick="save_course();">Save course</button>
    </div>
    <div class = "rightcol" id="rightcol_id">
        <div class="edit_input_title" id="edit_input_title_id" contenteditable="true" data-placeholder="Enter course title..." spellcheck="true"
             data-medium-editor-element="true" role="textbox"></div>
        <div class="material_title" data-medium-editor-element="true">Theme</div>
        <div class="edit_input_text" id = "edit_input_text" name="editable_input" contenteditable="true" data-placeholder="Enter text..." spellcheck="true"
             data-medium-editor-element="true" role="textbox" aria-multiline="true"></div>
        <div class="material_title" data-medium-editor-element="true">Description</div>
        <div class="edit_description" id = "edit_description_id" name="editable_desc" contenteditable="true" data-placeholder="Enter description..." spellcheck="true"
             data-medium-editor-element="true" role="textbox" aria-multiline="true"></div>
    </div>
</div>
<form method="post" id="data_send" action="addcourseprocess.jsp">
    <input hidden="true" id="course_title_form" name="course_title" value="">
    <input hidden="true" id="theme_form" name="theme" value="">
    <input hidden="true" id="description_form" name="description" value="">
</form>

<div class="popupcont" id="popupcont">
    <div class="popup" id="popup">
        <div class="operstatus">Fill all fields!</div>
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

</body>
</html>
