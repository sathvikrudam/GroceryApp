package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ConfirmOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String payment = request.getParameter("payment");

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (userId == null) {
            response.sendRedirect("jsp/login.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/grocerydb", "root", "");

            // Move items from cart to order_items
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO order_items (user_id, item_id, quantity) " +
                "SELECT user_id, item_id, quantity FROM cart WHERE user_id = ?"
            );
            ps.setInt(1, userId);
            ps.executeUpdate();

            // Clear cart
            PreparedStatement clear = con.prepareStatement("DELETE FROM cart WHERE user_id = ?");
            clear.setInt(1, userId);
            clear.executeUpdate();

            con.close();

            out.println("<html><body style='font-family:Arial;padding:20px;'>");
            out.println("<h2>✅ Order Placed Successfully!</h2>");
            out.println("<p>Payment Method: <strong>" + payment + "</strong></p>");
            out.println("<p>Thank you for shopping with us.</p>");
            out.println("<a href='jsp/shop.jsp'>🛍️ Continue Shopping</a>");
            out.println("</body></html>");

        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}

