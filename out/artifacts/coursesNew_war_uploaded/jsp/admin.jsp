<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="css/admin.css">
    <script src="js/admin.js"></script>
</head>
<body>
<jsp:include page="header/header.jsp"/>
<div class="main">
    <div class="title">Admin Name</div>
    <div class=contentt>
        <div id="leftcol">
            <div class="actbuttons">
                <div class="adminbuttons">
                    <div class="butt"><button onclick="showAddForm()" id="addingbuton" type="button" name="button">Create new user</button></div>
                    <div class="butt"><button onclick="showDelForm()" id="delbutton" type="button" name="button">Delete user</button></div>
                    <div class="butt"><button onclick="showEditForm()" id="editbutton" type="button" name="button">Edit user</button></div>
                </div>
            </div>
        </div>

        <div id="rightcol">

            <form action="createprocess.jsp" method="post" class="createuser" id="createuserform">
                <div id="createnewuser">Create new user</div>
                <div class="leftcolform">
                    <div class="textonform1">Name<input name="uname" type="text"  value="" required>*</div>
                    <div class="textonform1">E-email<input name="email" type="text"  value="" required>*</div>
                    <div class="textonform1">Password<input name="password" type="text" value="" required>*</div>
                    <div class="textonform1">Confirm password<input name="password_cp" type="text" value="" required>*</div>
                    <div class="textonform2">Personal info<textarea id="info" name="info" rows="4" cols="33"></textarea></div>
                    <div class="textonform1">Role*
                        <div class="radioGroup">
                            <div class="rbutt">
                                <p><input type="radio" id="student"
                                          name="role" value="student">student</p>
                            </div>
                            <div class="rbutt">
                                <p><input type="radio" id="lecturer"
                                          name="role" value="lecturer">lecturer</p>
                            </div>
                        </div>
                    </div>
                </div>
                <button id="butt" type="submit" name="button">Add</button>
            </form>

            <form action="deleteprocess.jsp" method="post" class="deleteuser" id="deleteuserform">
                <div id="deleteexistuser">Delete user</div>
                <div class="leftcolform">
                    <div class="searchfield"> Search <div class="forp"><p>
                        <input list="q" name = "q">
                        <datalist id="q">
                            <%
                                Class.forName("com.mysql.jdbc.Driver");

                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
                                PreparedStatement pst = null;

                                try {
                                    pst = conn.prepareStatement("SELECT login FROM `user`");
                                } catch (SQLException e) {
                                    out.println("SQL querry qreating error");
                                }

                                ResultSet rs = pst.executeQuery();

                                while(rs.next()){
                            %>
                            <option value="<%=rs.getString(1)%>"></option>
                            <%
                                }
                            %>
                    </p></div></div>
                </div>

                <button onclick="openPopUp()" id="butt1" type="submit" name="button">Delete</button>
            </form>


            <div class="leftcolform">
                <div id="searchEdit">
                    <div id="editexistuser">Edit user</div>
                        <form action="searchprocess.jsp" id = "searchuserform">
                            <div class="searchfield"> Search <div class="forp"><p>

                                <input id = "rowS" type="search" name="user" list = "user" placeholder="Search user">
                                <input type="image" id = "buttonSearch1" src="header/search.png" alt="Search" onclick="searchprocess.jsp">

                            </p></div></div>

                <datalist id="user">
                    <%
                        rs.first();
                        while(rs.next()){
                    %>
                    <option value="<%=rs.getString(1)%>"></option>
                    <%
                        }
                    %>
                </datalist>
                <%
                    String email = (String)request.getAttribute("email");
                    String user_name = (String)request.getAttribute("user_name");
                    String role = (String)request.getAttribute("role");

                    String description = (String)request.getAttribute("description");
                    if (email == null)
                        email = "";
                    if (user_name == null)
                        user_name = "";
                    if (role == null)
                        role = "student";
                    if (description == null)
                        description = "";

                %>
            </form>

            <form action="editprocess.jsp" method="post" class="editeuser" id="editeuserform">
                    <div class="textonform1">Login*<input type="text" name="email" id="email" value="<%=email%>"></div>
                    <div class="textonform1">Name*<input type="text" name="uname" id="uname" value="<%=user_name%>"></div>
                    <div class="textonform2">Personal info<textarea id="info" name="info" rows="4" cols="33"><%=description%></textarea></div>
                    <div class="textonform1">Role
                        <div class="radioGroup">

                            <div class="rbutt">
                                <p><input type="radio" id="student"
                                          name="role" value="student" <%if (new String("student").equals(role)) {%>checked="checked"<%}%>>student</p>
                            </div>
                            <div class="rbutt">
                                <p><input type="radio" id="lecturer"
                                          name="role" value="lecturer" <%if (new String("lecturer").equals(role)) {%>checked="checked"<%}%>>lecturer</p>
                            </div>
                        </div>
                    </div>
                <button onclick="openPopUp()" id="butt" type="submit" name="button">Save</button>
            </form>
        </div>
                </div>
        </div>
        </div>
    </div>

    <div class="popupcont" id="popupcont">
        <div class="popup" id="popup">
            <div class="operstatus"><%=request.getAttribute("textMsg")%></div>
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

    <%
        if (request != null && request.getAttribute("flag") != null)
        { %>
    <script type="text/javascript">
        showEditForm();
    </script>
    <%
            request.setAttribute("flag", null);
        }
    %>
</div>
</body>
<footer class="foot">
    <div class="footcont">
        <div class="contact">
            <p><strong>Contacts:</strong>     maxuaforever@gmail.com</p>
            <div class="copyright">
                <p>&copy 2009 - 2018 All rights reserved</p>
            </div>
        </div>
    </div>
</footer>
</html>