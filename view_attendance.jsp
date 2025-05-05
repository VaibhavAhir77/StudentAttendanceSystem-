<%@ page import="java.sql.*" %>
<%@ include file="db.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Attendance</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2 class="mb-4">View Attendance</h2>

        <%-- Handle soft delete if delete_id is passed --%>
        <%
            String deleteId = request.getParameter("delete_id");
            String deleteDate = request.getParameter("delete_date");

            if (deleteId != null && deleteDate != null) {
                PreparedStatement delStmt = con.prepareStatement(
                    "UPDATE attendance SET deleted = TRUE WHERE student_id = ? AND date = ?"
                );
                delStmt.setString(1, deleteId);
                delStmt.setString(2, deleteDate);
                delStmt.executeUpdate();
                out.print("<div class='alert alert-success'>Attendance record soft deleted.</div>");
            }
        %>

        <%
            try {
                String query = "SELECT s.name, a.date, a.status, a.student_id " +
                               "FROM attendance a " +
                               "JOIN students s ON a.student_id = s.id " +
                               "WHERE a.deleted = FALSE " +
                               "ORDER BY a.date DESC";
                Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                ResultSet rs = st.executeQuery(query);

                if (rs.next()) {
        %>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Student Name</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
        <%
                    rs.beforeFirst();
                    while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getDate("date") %></td>
                        <td><%= rs.getString("status") %></td>
                      <td>
    <a class="btn btn-warning btn-sm"
       href="edit_attendance.jsp?student_id=<%= rs.getInt("student_id") %>&date=<%= rs.getDate("date") %>">
        Edit
    </a>
    <a class="btn btn-danger btn-sm"
       href="view_attendance.jsp?delete_id=<%= rs.getInt("student_id") %>&delete_date=<%= rs.getDate("date") %>"
       onclick="return confirm('Are you sure you want to delete this record?');">
        Delete
    </a>
</td>

                    </tr>
        <%
                    }
        %>
                </tbody>
            </table>
        <%
                } else {
                    out.print("<div class='alert alert-info'>No attendance records found.</div>");
                }
            } catch (Exception e) {
                out.print("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            }
        %>

        <a href="mark_attendance.jsp" class="btn btn-primary mt-3">Mark Attendance</a>
        <a href="addStudent.jsp" class="btn btn-secondary mt-3">Add Student</a>
    </div>
</body>
</html>
