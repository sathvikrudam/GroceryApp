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
<h2>All Orders</h2>
<table border="1">
<tr>
<th>Order ID</th>
<th>User ID</th>
<th>Order Date</th>
<th>Status</th>
</tr>
<%
    try (Connection con = DBConnection.getConnection();
         Statement st = con.createStatement();
         ResultSet rs = st.executeQuery("SELECT * FROM orders ORDER BY order_date DESC")) {
        while(rs.next()) {
%>
<tr>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getInt("user_id") %></td>
<td><%= rs.getTimestamp("order_date") %></td>
<td><%= rs.getString("status") %></td>
</tr>
<%
        }
    } catch(Exception e) { out.println("Error: " + e.getMessage()); }
%>
</table>
<a href="admin_dashboard.jsp">Back to Dashboard</a>
</body>
</html>

