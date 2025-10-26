<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - GroceryApp</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
<h2>Welcome to GroceryApp</h2>

<% 
    String errorMsg = (String) request.getAttribute("errorMsg");
    if(errorMsg != null) { 
%>
<p style="color:red;"><%= errorMsg %></p>
<% } %>

<form method="post" action="<%= request.getContextPath() %>/LoginServlet">
    <table>
        <tr>
            <td>Username / Email:</td>
            <td><input type="text" name="email" required></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input type="password" name="password" required></td>
        </tr>
        <tr>
            <td>Login as:</td>
            <td>
                <select name="role">
                    <option value="user">User</option>
                    <option value="admin">Admin / Seller</option>
                </select>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="Login">
            </td>
        </tr>
    </table>
</form>

<p>
    New User? <a href="<%= request.getContextPath() %>/jsp/register.jsp">Register as User</a><br>
    New Seller/Admin? <a href="<%= request.getContextPath() %>/jsp/register_admin.jsp">Register as Seller/Admin</a>
</p>

</body>
</html>
