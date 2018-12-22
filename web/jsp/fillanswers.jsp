<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>

<%
    //request.setAttribute("course_id", "4");
    //session.setAttribute("name", "student");
    String course_id = request.getParameter("course_id");
    String test_id = request.getParameter("test_id");
    String student = session.getAttribute("name").toString();

    //session.setAttribute("name", "student");
    //String user = session.getAttribute("name").toString();

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT id, isOpen FROM question WHERE test = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);

    ResultSet rs = pst.executeQuery();
    int n = 1;
    while(rs.next()) {
        request.setAttribute("quest_id" + n, rs.getString("id"));
        request.setAttribute("quest_isOpen" + n, rs.getString("isOpen"));
        String isOpen = request.getAttribute("quest_isOpen"+n).toString();
        String answer = request.getParameter("ans"+n);
        if(isOpen.equals("1")) {
            PreparedStatement pst2 = null;
            try {
                pst2 = conn.prepareStatement("INSERT INTO answer(question, a_text, coefficient) VALUES(?, ?, null)");
            } catch (SQLException e) {
                out.println("SQL query creating error");
            }
            String question = request.getAttribute("quest_id" + n).toString();
            pst2.setString(1, question);
            pst2.setString(2, answer);

            pst2.executeUpdate();

            try {
                pst2 = conn.prepareStatement("SELECT MAX(id) as ans_id FROM answer");
            } catch (SQLException e) {
                out.println("SQL query creating error");
            }

            ResultSet rs2 = pst2.executeQuery();
            if (rs2.next()) {
                String ans_id = rs2.getString("ans_id").toString();


            try {
                pst2 = conn.prepareStatement("INSERT INTO studentanswer(student, answer) VALUES(?, ?)");
            } catch (SQLException e) {
                out.println("SQL query creating error");
            }
            pst2.setString(1, student);
            pst2.setString(2, ans_id);

            pst2.executeUpdate();
            }
        }
        else {
            PreparedStatement pst2 = null;
            try {
                pst2 = conn.prepareStatement("INSERT INTO studentanswer(student, answer) VALUES(?, ?)");
            } catch (SQLException e) {
                out.println("SQL query creating error");
            }
            pst2.setString(1, student);
            pst2.setString(2, answer);

            pst2.executeUpdate();
        }
        n++;
    }


    request.setAttribute("textMsg", "Answers saved!");
    %>
    <jsp:include page="course.jsp?course_id=<%=course_id%>" flush="true" />
    <%
%>