package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class AddItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if(session.getAttribute("adminId") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/admin_login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        try (Connection con = DBConnection.getConnection()) {
            String sql = "INSERT INTO items(name, category, price, stock) VALUES(?,?,?,?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, category);
                ps.setDouble(3, price);
                ps.setInt(4, stock);
                ps.executeUpdate();
            }
            response.sendRedirect(request.getContextPath() + "/jsp/admin_dashboard.jsp");
        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error adding item: " + e.getMessage());
        }
    }
}

