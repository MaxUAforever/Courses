<%--
  Created by IntelliJ IDEA.
  User: User646
  Date: 18.11.2018
  Time: 12:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
<head>
    <title>Header part</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/addlecture.css">
    <script src="js/addlecture.js"></script>
</head>
<body>
<header>
    <div class = "logo">
        <img src="header/logo.png" alt="logo">
    </div>
    <headercount>
        <div class="item"><a href="">Courses</a></div>
        <div class="item"><a href="">About</a></div>
        <div class="item">
            <form action="login.jsp">
                <p><input type="search" name="q" placeholder="Search courses">
                    <input type="image" id = "buttonSearch" src="header/search.png" alt="Search">
                </p>
            </form>
        </div>
    </headercount>
    <div class="reg">
        <div id="adminimg"></div>
        <a href="login.jsp"><%out.print(session.getAttribute("name"));%><br>Log Out</a>
    </div>
</header>
<div class="main_layer">
    <div class="title">Course title</div>
    <hr>

    <div class="leftcol">
        <button class="button" id="button_main" onclick="save_lecture();">Save lecture</button>
        <button class="button" id="button_main" onclick="add_input();">+ Add text</button>
        <button class="button" id="button_main" onclick="add_photo();">+ Add picture</button>
    </div>
    <div class = "rightcol" id="rightcol_id">
        <div class="edit_input_title" contenteditable="true" data-placeholder="Enter title..." spellcheck="true"
             data-medium-editor-element="true" role="textbox"></div>
        <div class="edit_input_text" id = "edit_input_text" name="editable_input" contenteditable="true" data-placeholder="Enter text..." spellcheck="true"
             data-medium-editor-element="true" role="textbox" aria-multiline="true"></div>
        <div class="input_photo" id="input_photo_id">
            <input type='file' id="upload" onchange="readURL(this);"/>
            <img src="#" id="upload-img" alt="image" />
        </div>

    </div>
</div>
<div id="lblValues">None</div>
</body>
</html>

