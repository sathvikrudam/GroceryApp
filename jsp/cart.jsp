<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="db.DBConnection" %>
<%@ page session="true" %>
<html>
<body>
<h2>Your Shopping Cart</h2>

<%
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if(cart == null || cart.isEmpty()) {
%>
<p>Your cart is empty!</p>
<a href="<%= request.getContextPath() %>/jsp/shop.jsp">Continue Shopping</a>
<%
    } else {
        double grandTotal = 0.0;

        try (Connection con = DBConnection.getConnection()) {
            for(Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                int itemId = entry.getKey();
                int quantity = entry.getValue();

                try (PreparedStatement ps = con.prepareStatement("SELECT name, price, stock FROM items WHERE id=?")) {
                    ps.setInt(1, itemId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if(rs.next()) {
                            String name = rs.getString("name");
                            double price = rs.getDouble("price");
                            int stock = rs.getInt("stock");
                            double total = price * quantity;
                            grandTotal += total;
%>
<p><%= name %> | Price: <%= price %> | Qty: <%= quantity %> | Total: <%= total %></p>
<%
                        }
                    }
                }
            }
        } catch(Exception e) {
            out.println("Error loading cart: " + e.getMessage());
            e.printStackTrace();
        }
%>
<p><b>Grand Total: <%= grandTotal %></b></p>
<form action="<%= request.getContextPath() %>/jsp/order_summary.jsp" method="get">
    <input type="submit" value="Place Order">
</form>

<a href="<%= request.getContextPath() %>/jsp/shop.jsp">Continue Shopping</a>
<% } %>
</body>
</html>
