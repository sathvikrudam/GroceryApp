package servlet;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // user or admin

        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps;
            if ("user".equalsIgnoreCase(role)) {
                ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
            } else if ("admin".equalsIgnoreCase(role)) {
                ps = con.prepareStatement("SELECT * FROM admins WHERE email=? AND password=?");
            } else {
                request.setAttribute("errorMsg", "Invalid role selected!");
                request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
                return;
            }

            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    HttpSession session = request.getSession();
                    if ("user".equalsIgnoreCase(role)) {
                        session.setAttribute("userId", rs.getInt("id"));
                        session.setAttribute("userName", rs.getString("name"));
                        response.sendRedirect(request.getContextPath() + "/jsp/shop.jsp");
                    } else {
                        session.setAttribute("adminId", rs.getInt("id"));
                        session.setAttribute("adminName", rs.getString("name"));
                        response.sendRedirect(request.getContextPath() + "/jsp/admin_dashboard.jsp");
                    }
                } else {
                    request.setAttribute("errorMsg", "Invalid credentials!");
                    request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
    }
}
