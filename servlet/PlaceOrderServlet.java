package servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import db.DBConnection;

public class PlaceOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.getWriter().println("Cart is empty!");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId"); 
        if(userId == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        List<Map<String,Object>> purchasedItems = new ArrayList<>();
        double total = 0;

        try (Connection con = DBConnection.getConnection()) {

            // 1️⃣ Calculate total amount first
            for(Map.Entry<Integer,Integer> entry : cart.entrySet()) {
                int itemId = entry.getKey();
                int quantity = entry.getValue();

                double price = 0;
                try (PreparedStatement ps = con.prepareStatement("SELECT price FROM items WHERE id=?")) {
                    ps.setInt(1, itemId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if(rs.next()) price = rs.getDouble("price");
                    }
                }
                total += price * quantity;
            }

            // 2️⃣ Insert order with total_amount
            String insertOrderSQL = "INSERT INTO orders(user_id, total_amount) VALUES(?, ?)";
            int orderId = 0;
            try (PreparedStatement ps = con.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, userId);
                ps.setDouble(2, total);
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if(rs.next()) orderId = rs.getInt(1);
                }
            }

            // 3️⃣ Insert order items and update stock
            for(Map.Entry<Integer,Integer> entry : cart.entrySet()) {
                int itemId = entry.getKey();
                int quantity = entry.getValue();

                double price = 0;
                int stock = 0;
                String name = "";

                try (PreparedStatement ps1 = con.prepareStatement("SELECT name, price, stock FROM items WHERE id=?")) {
                    ps1.setInt(1, itemId);
                    try (ResultSet rs = ps1.executeQuery()) {
                        if(rs.next()) {
                            name = rs.getString("name");
                            price = rs.getDouble("price");
                            stock = rs.getInt("stock");
                        }
                    }
                }

                // Insert order item
                try (PreparedStatement ps2 = con.prepareStatement(
                        "INSERT INTO order_items(order_id, item_id, quantity, price) VALUES(?,?,?,?)")) {
                    ps2.setInt(1, orderId);
                    ps2.setInt(2, itemId);
                    ps2.setInt(3, quantity);
                    ps2.setDouble(4, price);
                    ps2.executeUpdate();
                }

                // Update stock
                try (PreparedStatement psUpdate = con.prepareStatement(
                        "UPDATE items SET stock=? WHERE id=?")) {
                    psUpdate.setInt(1, stock - quantity);
                    psUpdate.setInt(2, itemId);
                    psUpdate.executeUpdate();
                }

                // Add to purchasedItems list
                Map<String,Object> item = new HashMap<>();
                item.put("name", name);
                item.put("qty", quantity);
                item.put("price", price);
                item.put("subtotal", price * quantity);
                purchasedItems.add(item);
            }

            // 4️⃣ Clear cart
            session.removeAttribute("cart");

            // 5️⃣ Store purchased items & total in session
            session.setAttribute("purchasedItems", purchasedItems);
            session.setAttribute("orderTotal", total);

            // 6️⃣ Forward to order_success.jsp
            RequestDispatcher rd = request.getRequestDispatcher("/jsp/order_success.jsp");
            rd.forward(request, response);

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Order failed: " + e.getMessage());
        }
    }
}
