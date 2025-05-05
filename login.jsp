<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<%
    if (request.getParameter("login") != null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
        ps.setString(1, username);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("username", username);
            response.sendRedirect("dashboard.jsp");
        } else {
            out.print("<div class='alert alert-danger'>Invalid credentials</div>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Login</h2>
    <form method="post">
        <div class="mb-3">
            <label>Username:</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Password:</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" name="login" class="btn btn-primary">Login</button>
        <a href="signup.jsp" class="btn btn-link">Sign Up</a>
    </form>
</div>
</body>
</html>
