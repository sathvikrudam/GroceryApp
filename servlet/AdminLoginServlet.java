package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            String sql = "SELECT id FROM admins WHERE username=? AND password=?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if(rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("adminId", rs.getInt("id"));
                        session.setAttribute("adminName", username);
                        response.sendRedirect(request.getContextPath() + "/jsp/admin_dashboard.jsp");
                    } else {
                        response.getWriter().println("Invalid credentials!");
                    }
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login failed: " + e.getMessage());
        }
    }
}

