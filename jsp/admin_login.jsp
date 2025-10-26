<%@ page session="true" %>
<html>
<body>
<h2>Admin Login</h2>
<form action="<%= request.getContextPath() %>/AdminLoginServlet" method="post">
    Username: <input type="text" name="username" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    <input type="submit" value="Login">
</form>
</body>
</html>

