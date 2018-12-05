<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<%@ page import="com.sun.org.apache.xpath.internal.operations.Bool" %>

<%
    //request.setAttribute("course_id", "4");
    session.setAttribute("name", "student");
    String course_id = request.getParameter("course_id");
    String test_id = request.getParameter("test_id");
    String student = session.getAttribute("name").toString();


    //session.setAttribute("name", "student");
    //String user = session.getAttribute("name").toString();

    Class.forName("com.mysql.jdbc.Driver");

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("SELECT answer.id, answer.question, answer.a_text FROM question INNER JOIN (answer INNER JOIN studentanswer ON answer.id = studentanswer.answer) ON question.id = answer.question WHERE question.isOpen = 1 AND question.test = ? AND studentanswer.student = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);
    pst.setString(2, student);

    ResultSet rs = pst.executeQuery();
    while(rs.next()) {
        String coefficient = request.getParameter("ans" + rs.getString("id"));
        PreparedStatement pst2 = null;

        try {
            pst2 = conn.prepareStatement("INSERT INTO answer(id, question, a_text, coefficient) VALUES(?, ?, ?, ?) ON DUPLICATE KEY UPDATE question = ?, a_text = ?, coefficient = ?");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }

        pst2.setString(1, rs.getString("id"));
        pst2.setString(2, rs.getString("question"));
        pst2.setString(3, rs.getString("a_text"));
        pst2.setString(4, coefficient);
        pst2.setString(5, rs.getString("question"));
        pst2.setString(6, rs.getString("a_text"));
        pst2.setString(7, coefficient);

        pst2.executeUpdate();
    }

    try {
        pst = conn.prepareStatement("SELECT isExam FROM test WHERE id = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);

    rs = pst.executeQuery();
    String isExam = "0";
    if(rs.next()) {
        isExam = rs.getString("isExam");
    }

    try {
        pst = conn.prepareStatement("SELECT answer.coefficient, question.points FROM question INNER JOIN (answer INNER JOIN studentanswer ON answer.id = studentanswer.answer) ON question.id = answer.question WHERE question.test = ? AND studentanswer.student = ?");
    } catch (SQLException e) {
        out.println("SQL query creating error");
    }

    pst.setString(1, test_id);
    pst.setString(2, student);

    rs = pst.executeQuery();
    int sum = 0;
    while(rs.next()) {
        sum+=Double.parseDouble(rs.getString("coefficient"))*Integer.parseInt(rs.getString("points"));
    }

    if(isExam.equals("0")) {

        try {
            pst = conn.prepareStatement("SELECT studentlesson.id, studentlesson.lesson, studentlesson.page FROM studentlesson INNER JOIN (lesson INNER JOIN test ON test.lesson = lesson.id) ON studentlesson.lesson = lesson.id WHERE test.id = ? AND studentlesson.student = ?");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }

        pst.setString(1, test_id);
        pst.setString(2, student);

        rs = pst.executeQuery();
        if (rs.next()) {

            PreparedStatement pst2 = null;
            try {
                pst2 = conn.prepareStatement("INSERT INTO studentlesson(id, student, lesson, page, mark) VALUES(?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE student = ?, lesson = ?, page = ?, mark = ?");
            } catch (SQLException e) {
                out.println("SQL query creating error");
            }

            pst2.setString(1, rs.getString("id"));
            pst2.setString(2, student);
            pst2.setString(3, rs.getString("lesson"));
            pst2.setString(4, rs.getString("page"));
            pst2.setInt(5, sum);
            pst2.setString(6, student);
            pst2.setString(7, rs.getString("lesson"));
            pst2.setString(8, rs.getString("page"));
            pst2.setInt(9, sum);

            pst2.executeUpdate();
        }
    }
    else{
        try {
            pst = conn.prepareStatement("SELECT subscribe.id, subscribe.course, subscribe.student FROM subscribe INNER JOIN (course INNER JOIN test ON test.lesson = course.id) ON subscribe.course = course.id WHERE test.id = ? AND subscribe.student = ?");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }

        pst.setString(1, test_id);
        pst.setString(2, student);

        rs = pst.executeQuery();
        if (rs.next()) {

            PreparedStatement pst2 = null;
            try {
                pst2 = conn.prepareStatement("INSERT INTO subscribe(id, student, course, mark) VALUES(?, ?, ?, ?) ON DUPLICATE KEY UPDATE student = ?, course = ?, mark = ?");
            } catch (SQLException e) {
                out.println("SQL query creating error");
            }

            pst2.setString(1, rs.getString("id"));
            pst2.setString(2, student);
            pst2.setString(3, rs.getString("course"));
            pst2.setInt(4, sum);
            pst2.setString(5, student);
            pst2.setString(6, rs.getString("course"));
            pst2.setInt(7, sum);

            pst2.executeUpdate();
        }
    }

    request.setAttribute("textMsg", "Marks saved! Mark is " + sum);
%>
<jsp:include page="course.jsp?course_id=<%=course_id%>" flush="true" />
<%
%>