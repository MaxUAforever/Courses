<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>

<%@ page import="java.io.File"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>

<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        Class.forName("com.mysql.jdbc.Driver");

        String courseID = request.getParameter("course_id");
        String lectureTitle = request.getParameter("lecture_title");
        String desc = request.getParameter("description");
        String text = request.getParameter("text");

        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
        PreparedStatement pst = null;

        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=0");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();


        try {
            pst = conn.prepareStatement("INSERT INTO `lesson` (course, less_name, description, material) VALUES (?, ?, ?, ?)");
        } catch (SQLException e) {
            out.println("SQL querry qreating error");
        }

        pst.setString(1, courseID);
        pst.setString(2, lectureTitle);
        pst.setString(3, desc);
        pst.setString(4, text);

        if (pst.executeUpdate() > 0) {
            request.setAttribute("textMsg", "Lecture created!");
        }
        else{
            request.setAttribute("textMsg", "Lecture create failed!");
        }

        try {
            pst = conn.prepareStatement("SET FOREIGN_KEY_CHECKS=1");
        } catch (SQLException e) {
            out.println("SQL query creating error");
        }
        pst.executeQuery();


        /*Images download*/
        /*File file;
        int maxFileSize = 5000 * 1024;
        int maxMemSize = 5000 * 1024;

        //ServletContext context = pageContext.getServletContext();
        //String filePath = context.getInitParameter("file-upload");

        String filePath = "c:/data/";
        String contentType = request.getContentType();

        if ((contentType.indexOf("multipart/form-data") >= 0)) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(maxMemSize);

            factory.setRepository(new File("c:/temp"));

            ServletFileUpload upload = new ServletFileUpload(factory);

            // maximum file size to be uploaded.
            upload.setSizeMax(maxFileSize);

            try {
                // Parse the request to get file items.
                List fileItems = upload.parseRequest(request);

                // Process the uploaded file items
                Iterator i = fileItems.iterator();

                while (i.hasNext()) {
                    FileItem fi = (FileItem)i.next();
                    if ( !fi.isFormField () ) {
                        // Get the uploaded file parameters
                        String fieldName = fi.getFieldName();
                        String fileName = fi.getName();
                        boolean isInMemory = fi.isInMemory();
                        long sizeInBytes = fi.getSize();

                        // Write the file
                        if( fileName.lastIndexOf("\\") >= 0 ) {
                            file = new File( filePath +
                                    fileName.substring( fileName.lastIndexOf("\\"))) ;
                        } else {
                            file = new File( filePath +
                                    fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                        }
                        fi.write( file ) ;
                    }
                }
            } catch(Exception ex) {
                System.out.println(ex);
            }
        } else {
            out.println("<p>No file uploaded</p>");
        }*/
    %>
    <jsp:include page="course.jsp?course_id=<%=courseID%>" flush="true" />
</body>
</html>
