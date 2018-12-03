function save_course(){
    document.getElementById("course_title_form").setAttribute("value", document.getElementById("edit_input_title_id").innerHTML.replace("'", "|"));
    document.getElementById("theme_form").setAttribute("value", document.getElementById("edit_input_text").innerHTML.replace("'", "|"));
    document.getElementById("description_form").setAttribute("value", document.getElementById("edit_description_id").innerHTML.replace("'", "|"));
    document.getElementById("data_send").submit();
};