<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<%
if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
}
    Connection conn = (Connection)application.getAttribute("con");

    if (request.getParameter("submit") != null) {
        String[] ids = request.getParameterValues("student_id[]");
        String date = request.getParameter("date");

        for (String id : ids) {
            String status = request.getParameter("status_" + id);
            PreparedStatement ps = conn.prepareStatement("INSERT INTO attendance(student_id, date, status) VALUES (?, ?, ?)");
            ps.setString(1, id);
            ps.setString(2, date);
            ps.setString(3, status);
            ps.executeUpdate();
        }
        out.print("<div class='alert alert-success'>Attendance Marked</div>");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Mark Attendance</h2>
        <form method="post">
            <div class="mb-3">
                <label>Date:</label>
                <input type="date" name="date" class="form-control" required>
            </div>
            <table class="table table-bordered">
                <tr>
                    <th>Name</th>
                    <th>Status</th>
                </tr>
                <%
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM students");
                    while (rs.next()) {
                        int id = rs.getInt("id");
                %>
                <tr>
<td>
    <div class="d-flex justify-content-between align-items-center">
        <span><%= rs.getString("name") %></span>
        <a href="edit_student.jsp?id=<%= id %>" class="btn btn-sm btn-warning ms-2">Edit</a>
    </div>
    <input type="hidden" name="student_id[]" value="<%= id %>">
</td>

                    <td>
                        <select name="status_<%= id %>" class="form-select">
                            <option value="Present">Present</option>
                            <option value="Absent">Absent</option>
                        </select>
                    </td>
                </tr>
                <% } %>
            </table>
            <button type="submit" name="submit" class="btn btn-primary">Submit</button>
        </form>
        
       
        <a href="dashboard.jsp" class="btn btn-secondary mt-3">Dashboard</a>
    </div>
</body>
</html>
