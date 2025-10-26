<%@ page session="true" %>
<%@ page import="java.sql.*, db.DBConnection" %>
<html>
<body>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    String idStr = request.getParameter("id");
    if(idStr == null) {
        response.sendRedirect("edit_inventory.jsp");
        return;
    }
    int id = Integer.parseInt(idStr);
    String name = "", category = "";
    double price = 0;
    int stock = 0;

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement("SELECT * FROM items WHERE id=?")) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if(rs.next()) {
                name = rs.getString("name");
                category = rs.getString("category");
                price = rs.getDouble("price");
                stock = rs.getInt("stock");
            }
        }
    } catch(Exception e) { out.println("Error: " + e.getMessage()); }
%>

<h2>Edit Item</h2>
<form action="UpdateItemServlet" method="post">
    <input type="hidden" name="id" value="<%=id%>">
    Name: <input type="text" name="name" value="<%=name%>" required><br><br>
    Category: <input type="text" name="category" value="<%=category%>"><br><br>
    Price: <input type="number" step="0.01" name="price" value="<%=price%>" required><br><br>
    Stock: <input type="number" name="stock" value="<%=stock%>" required><br><br>
    <input type="submit" value="Update Item">
</form>

<a href="edit_inventory.jsp">Back to Inventory</a>
</body>
</html>

