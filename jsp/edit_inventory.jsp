<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Inventory</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
</head>
<body>
<h2>Admin Dashboard - Edit Inventory</h2>
<p><a href="<%=request.getContextPath()%>/jsp/admin_dashboard.jsp">Back to Dashboard</a></p>
<p><a href="<%=request.getContextPath()%>/jsp/add_item.jsp">Add New Item</a></p>

<table border="1" cellpadding="10" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Category</th>
        <th>Price</th>
        <th>Stock</th>
        <th>Actions</th>
    </tr>
<%
    try (Connection con = DBConnection.getConnection()) {
        String sql = "SELECT * FROM items WHERE active = TRUE";
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("category") %></td>
        <td><%= rs.getDouble("price") %></td>
        <td><%= rs.getInt("stock") %></td>
        <td>
            <a href="<%= request.getContextPath() %>/jsp/edit_item.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
            <a href="<%= request.getContextPath() %>/DeleteItemServlet?id=<%= rs.getInt("id") %>"
               onclick="return confirm('Are you sure you want to delete this item?');">Delete</a>
        </td>
    </tr>
<%
            }
        }
    } catch(Exception e) {
        out.println("<tr><td colspan='6' style='color:red;'>Error loading items: " + e.getMessage() + "</td></tr>");
    }
%>
</table>
</body>
</html>
