<%@ page session="true" %>
<html>
<body>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<h2>Add New Item</h2>
<form action="<%= request.getContextPath() %>/AddItemServlet" method="post">
    Name: <input type="text" name="name" required><br><br>
    Category: <input type="text" name="category"><br><br>
    Price: <input type="number" step="0.01" name="price" required><br><br>
    Stock: <input type="number" name="stock" required><br><br>
    <input type="submit" value="Add Item">
</form>
<a href="admin_dashboard.jsp">Back to Dashboard</a>
</body>
</html>

