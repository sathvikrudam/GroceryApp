<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<Map<String,Object>> purchasedItems = (List<Map<String,Object>>) session.getAttribute("purchasedItems");
    Double orderTotal = (Double) session.getAttribute("orderTotal");
    if(purchasedItems == null) {
        response.sendRedirect("shop.jsp");
        return;
    }
%>
<html>
<head>
    <title>Order Summary</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #f4f4f4; }
        .total { text-align: right; font-size: 18px; font-weight: bold; }
        .btn { padding: 10px 15px; background-color: green; color: white; border: none; cursor: pointer; }
        .btn:hover { background-color: darkgreen; }
    </style>
</head>
<body>
    <h2>🧾 Order Summary</h2>
    <table>
        <tr><th>Item</th><th>Price</th><th>Qty</th><th>Subtotal</th></tr>
        <%
            for(Map<String,Object> item : purchasedItems) {
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
            <td class="total">₹<%= orderTotal %></td>
        </tr>
    </table>

    <div style="margin-top:20px;">
        <h3>💵 Payment Method: Cash on Delivery (COD)</h3>
        <a href="shop.jsp"><button class="btn">🛍️ Continue Shopping</button></a>
    </div>

<%
    // Clear session attributes after displaying
    session.removeAttribute("purchasedItems");
    session.removeAttribute("orderTotal");
%>
</body>
</html>
