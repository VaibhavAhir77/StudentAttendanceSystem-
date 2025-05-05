<%@ page import="java.sql.*" %>
<%
    Connection con = (Connection)application.getAttribute("con");
    if (con == null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/attendance_db", "root", "");
            application.setAttribute("con", con);
        } catch(Exception e) {
            out.print("<div class='alert alert-danger'>Database Connection Error: " + e.getMessage() + "</div>");
        }
    }
%>
