<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>

<%
    String studentId = request.getParameter("student_id");
    String date = request.getParameter("date");

    if (studentId == null || date == null) {
        out.print("<div class='alert alert-danger'>Invalid request.</div>");
        return;
    }

    String status = "";

    if (request.getParameter("update") != null) {
        // Update the attendance
        status = request.getParameter("status");
        PreparedStatement ps = con.prepareStatement("UPDATE attendance SET status = ? WHERE student_id = ? AND date = ?");
        ps.setString(1, status);
        ps.setString(2, studentId);
        ps.setString(3, date);
        int rows = ps.executeUpdate();
        if (rows > 0) {
            response.sendRedirect("view_attendance.jsp?msg=updated");
            return;
        } else {
            out.print("<div class='alert alert-danger'>Update failed.</div>");
        }
    } else {
        // Load the existing attendance
        PreparedStatement ps = con.prepareStatement("SELECT status FROM attendance WHERE student_id = ? AND date = ?");
        ps.setString(1, studentId);
        ps.setString(2, date);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            status = rs.getString("status");
        } else {
            out.print("<div class='alert alert-warning'>Record not found.</div>");
            return;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Attendance</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Edit Attendance</h2>
        <form method="post">
            <div class="mb-3">
                <label>Status:</label>
                <select name="status" class="form-select" required>
                    <option value="Present" <%= "Present".equals(status) ? "selected" : "" %>>Present</option>
                    <option value="Absent" <%= "Absent".equals(status) ? "selected" : "" %>>Absent</option>
                </select>
            </div>
            <button type="submit" name="update" class="btn btn-primary">Update</button>
            <a href="view_attendance.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>
