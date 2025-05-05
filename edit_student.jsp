<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<%
    String id = request.getParameter("id");
    String name = "";

    if (id == null) {
        out.print("<div class='alert alert-danger'>No student ID provided.</div>");
        return;
    }

    if (request.getParameter("update") != null) {
        name = request.getParameter("name");
        PreparedStatement ps = con.prepareStatement("UPDATE students SET name = ? WHERE id = ?");
        ps.setString(1, name);
        ps.setString(2, id);
        int rows = ps.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("mark_attendance.jsp");
            return;
        } else {
            out.print("<div class='alert alert-danger'>Update failed.</div>");
        }
    } else {
        PreparedStatement ps = con.prepareStatement("SELECT name FROM students WHERE id = ?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
        } else {
            out.print("<div class='alert alert-warning'>Student not found.</div>");
            return;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Edit Student Name</h2>
        <form method="post">
            <div class="mb-3">
                <label>Student Name:</label>
                <input type="text" name="name" value="<%= name %>" class="form-control" required>
            </div>
            <button type="submit" name="update" class="btn btn-primary">Update</button>
            <a href="mark_attendance.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
