<%@ page session="true" %>
<%@ page import="java.sql.*, db.DBConnection" %>
<html>
<body>
<%
    if(session.getAttribute("adminId") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<h2>Welcome Admin: <%= session.getAttribute("adminName") %></h2>

<h3>Manage Inventory</h3>
<a href="add_item.jsp">Add New Item</a><br>
<a href="edit_inventory.jsp">Edit Inventory</a><br><br>

<h3>View Orders</h3>
<a href="view_orders.jsp">All Orders</a><br><br>

<a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>

</body>
</html>

