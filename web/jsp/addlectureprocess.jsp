<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>

<%@ page import="java.io.File"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.List"%>


<html>
<head>
    <title>Student page</title>
    <script src="js/addlecture.js"></script>
</head>
<body onload="get_text()">
<!--<form method="post" id="data_send" action="addlectureconfirm.jsp">
    <input type="text" id="course_title_id" name="course_title" value="">
    <input type="hidden" id="lecture_title_id" name="lecture_title" value="">
    <input type="hidden" id="description_id" name="description" value="">
    <input type="hidden" id="text_id" name="text" value="">
</form>-->

</body>
</html>
<%
    /*Class.forName("com.mysql.jdbc.Driver");

    String course_title = "<script>sessionStorage.getItem(\"course\")</script>";

    out.println(course_title);*/
    /*Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/courses_cp?" + "user=root&password=root");
    PreparedStatement pst = null;

    try {
        pst = conn.prepareStatement("INSERT INTO `lesson` (course, less_name, description, material) VALUES (var_cour_id, ?, ?, ?)");
    } catch (SQLException e) {
        out.println("SQL querry qreating error");
    }*/

    /*
    pst.setString(1, );
    pst.setString(2, password);
    pst.setString(3, role);
    pst.setString(4, uname);
    pst.setString(5, info);


    }
*/


    /*File file;
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 5000 * 1024;
    ServletContext context = pageContext.getServletContext();
    String filePath = context.getInitParameter("file-upload");

    // Verify the content type
    String contentType = request.getContentType();

    if ((contentType.indexOf("multipart/form-data") >= 0)) {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);

        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File("c:\\temp"));

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // maximum file size to be uploaded.
        upload.setSizeMax( maxFileSize );

        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();

            out.println("JSP File upload</title>");

            while ( i.hasNext () ) {
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
                    out.println("Uploaded Filename: " + filePath +
                            fileName + "<br>");
                }
            }
        } catch(Exception ex) {
            System.out.println(ex);
        }
    } else {
        out.println("<p>No file uploaded</p>");
    }*/
%>


