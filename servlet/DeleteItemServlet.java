package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class DeleteItemServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if(session.getAttribute("adminId") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/admin_login.jsp");
            return;
        }

        int itemId = Integer.parseInt(request.getParameter("id"));

        try (Connection con = DBConnection.getConnection()) {
            // Soft delete: mark item as inactive
            try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE items SET active = FALSE WHERE id=?")) {
                ps.setInt(1, itemId);
                int rows = ps.executeUpdate();
                if(rows > 0) {
                    response.sendRedirect(request.getContextPath() + "/jsp/edit_inventory.jsp");
                } else {
                    response.getWriter().println("Item not found or already inactive.");
                }
            }

        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Delete failed: " + e.getMessage());
        }
    }
}
