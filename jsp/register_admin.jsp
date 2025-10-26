<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register as Seller/Admin</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
<h2>Register as Seller/Admin</h2>

<% 
    String errorMsg = (String) request.getAttribute("errorMsg");
    if(errorMsg != null) { 
%>
<p style="color:red;"><%= errorMsg %></p>
<% } %>

<form method="post" action="<%= request.getContextPath() %>/RegisterAdminServlet">
    <table>
        <tr>
            <td>Name:</td>
            <td><input type="text" name="name" required></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><input type="email" name="email" required></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input type="password" name="password" required></td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="Register">
            </td>
        </tr>
    </table>
</form>

<p>Already have an account? <a href="<%= request.getContextPath() %>/jsp/login.jsp">Login here</a></p>
</body>
</html>

