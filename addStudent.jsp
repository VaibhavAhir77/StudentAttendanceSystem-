<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">Add New Student</h2>

        <%
            if (request.getParameter("submit") != null) {
                String name = request.getParameter("name");

                try {
                    PreparedStatement ps = con.prepareStatement("INSERT INTO students(name) VALUES(?)");
                    ps.setString(1, name);
                    int rows = ps.executeUpdate();

                    if (rows > 0) {
                        out.print("<div class='alert alert-success'>Student added successfully!</div>");
                    } else {
                        out.print("<div class='alert alert-danger'>Failed to add student.</div>");
                    }
                } catch (Exception e) {
                    out.print("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                }
            }
        %>

        <form method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Student Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <button type="submit" name="submit" class="btn btn-primary">Add Student</button>
        </form>

        <a href="mark_attendance.jsp" class="btn btn-link mt-3">Go to Mark Attendance</a>
    </div>
</body>
</html>
