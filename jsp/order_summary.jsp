<%@ page import="java.util.*,java.sql.*" %>
<%@ page session="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Get user ID from session
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    double total = 0;
    List<Map<String, Object>> items = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/grocerydb?useUnicode=true&characterEncoding=UTF-8", 
            "root", "sathvik1"
        );
        PreparedStatement ps = con.prepareStatement(
            "SELECT c.id, i.name, i.price, c.quantity FROM cart c JOIN items i ON c.item_id = i.id WHERE c.user_id=?"
        );
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", rs.getInt("id"));
            item.put("name", rs.getString("name"));
            item.put("price", rs.getDouble("price"));
            item.put("qty", rs.getInt("quantity"));
            double subtotal = rs.getDouble("price") * rs.getInt("quantity");
            total += subtotal;
            item.put("subtotal", subtotal);
            items.add(item);
        }
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Summary</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #f4f4f4; }
        .total { text-align: right; font-size: 18px; font-weight: bold; }
        .payment-option { margin-top: 20px; }
        .btn { padding: 10px 15px; background-color: green; color: white; border: none; cursor: pointer; }
        .btn:hover { background-color: darkgreen; }
    </style>
</head>
<body>
    <h2>🧾 Order Summary</h2>
    <table>
        <tr><th>Item</th><th>Price</th><th>Qty</th><th>Subtotal</th></tr>
        <%
            for (Map<String, Object> item : items) {
        %>
            <tr>
                <td><%= item.get("name") %></td>
                <td>₹<%= item.get("price") %></td>
                <td><%= item.get("qty") %></td>
                <td>₹<%= item.get("subtotal") %></td>
            </tr>
        <%
            }
        %>
        <tr>
            <td colspan="3" class="total">Total</td>
            <td class="total">₹<%= total %></td>
        </tr>
    </table>

    <div class="payment-option">
        <h3>💵 Select Payment Method:</h3>
        <form action="<%=request.getContextPath()%>/PlaceOrderServlet" method="post">
    <input type="radio" name="payment" value="COD" checked> Cash on Delivery (COD)
    <br><br>
    <button type="submit" class="btn">✅ Confirm Order</button>
</form>

    </div>
</body>
</html>
