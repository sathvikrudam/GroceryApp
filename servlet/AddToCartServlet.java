package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

import db.DBConnection;

public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if(cart == null) cart = new HashMap<>();

        int itemId = Integer.parseInt(request.getParameter("item_id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Optional: Check stock
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT stock FROM items WHERE id=?")) {
            ps.setInt(1, itemId);
            try (ResultSet rs = ps.executeQuery()) {
                if(rs.next()) {
                    int stock = rs.getInt("stock");
                    if(quantity > stock) quantity = stock;
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        }

        cart.put(itemId, cart.getOrDefault(itemId, 0) + quantity);
        session.setAttribute("cart", cart);

        response.sendRedirect(request.getContextPath() + "/jsp/shop.jsp");
    }
}
