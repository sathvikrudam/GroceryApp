<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<html>
<head>
    <title>Grocery Shop</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        input[type=number] { width: 50px; }
        form { margin: 0; }
        h2, h3 { margin-left: 10px; }
        a { margin-right: 15px; }
    </style>
</head>
<body>
<h2>Welcome, <%= session.getAttribute("userName") %>!</h2>
<h3>Available Grocery Items</h3>

<%
try (Connection con = DBConnection.getConnection();
     Statement st = con.createStatement();
     ResultSet rs = st.executeQuery("SELECT * FROM items")) {

%>

<table>
    <tr>
        <th>Name</th>
        <th>Category</th>
        <th>Price</th>
        <th>Stock</th>
        <th>Action</th>
    </tr>

<%
while(rs.next()) {
    int itemId = rs.getInt("id");
    String name = rs.getString("name");
    String category = rs.getString("category");
    double price = rs.getDouble("price");
    int stock = rs.getInt("stock");
%>

<tr>
    <td><%= name %></td>
    <td><%= category %></td>
    <td><%= price %></td>
    <td><%= stock %></td>
    <td>
        <% if(stock > 0) { %>
        <form action="<%= request.getContextPath() %>/AddToCartServlet" method="post">
            <input type="hidden" name="item_id" value="<%= itemId %>">
            <input type="number" name="quantity" value="1" min="1" max="<%= stock %>">
            <input type="submit" value="Add to Cart">
        </form>
        <% } else { %>
            Out of Stock
        <% } %>
    </td>
</tr>

<% } %>
</table>

<p>
    <a href="<%= request.getContextPath() %>/jsp/cart.jsp">View Cart</a> |
    <a href="<%=request.getContextPath()%>/LogoutServlet">Logout</a>
</p>

<% } catch(Exception e) { %>
<p style="color:red;">Error loading items: <%= e.getMessage() %></p>
<%
    e.printStackTrace();
}
%>

</body>
</html>
