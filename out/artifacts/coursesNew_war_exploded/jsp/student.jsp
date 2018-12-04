<%--
  Created by IntelliJ IDEA.
  User: Max
  Date: 10.11.2018
  Time: 23:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student page</title>
</head>
<body>

<jsp:include page="header/header.jsp"/>
<!--<header>
    <div class = "logo">
        <img src="header/logo.png" alt="logo">
    </div>
    <headercount>
        <div class="item"><a href="allcourses.jsp">Courses</a></div>
        <div class="item"><a href="">About</a></div>
        <div class="item">
            <form action="allcourses.jsp" method="post" class="searchcontainer">
                <p><input type="search" name="q" placeholder="Search courses">
                    <input type="image" id = "buttonSearch" src="header/search.png" alt="Search">
                </p>
            </form>
        </div>
    </headercount>
    <div class="reg">
        <div id="adminimg"></div>
        <a href="lecturer.jsp" class="header_name"><%/*out.print(session.getAttribute("name"));*/%></a>
        <br>
        <a href="login.jsp">Log Out</a>
    </div>
</header>-->

    <% out.print("You are student"); %>
</body>
</html>
