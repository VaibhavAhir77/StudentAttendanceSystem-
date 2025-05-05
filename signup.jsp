<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>
<%
    if (request.getParameter("signup") != null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        PreparedStatement ps = con.prepareStatement("INSERT INTO users(username, password) VALUES(?, ?)");
        ps.setString(1, username);
        ps.setString(2, password);
        ps.executeUpdate();

        out.print("<div class='alert alert-success'>User Registered. <a href='login.jsp'>Login Now</a></div>");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Sign Up</h2>
    <form method="post">
        <div class="mb-3">
            <label>Username:</label>
            <input type="text" name="username" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Password:</label>
            <input type="password" name="password" class="form-control" required>
        </div>
        <button type="submit" name="signup" class="btn btn-success">Sign Up</button>
        <a href="login.jsp" class="btn btn-link">Back to Login</a>
    </form>
</div>
</body>
</html>
