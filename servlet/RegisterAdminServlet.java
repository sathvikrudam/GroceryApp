package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class RegisterAdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {
            // Check if email already exists
            PreparedStatement check = con.prepareStatement("SELECT * FROM admins WHERE email=?");
            check.setString(1, email);
            ResultSet rs = check.executeQuery();
            if(rs.next()) {
                request.setAttribute("errorMsg", "Email already registered!");
                request.getRequestDispatcher("/jsp/register_admin.jsp").forward(request, response);
                return;
            }

            // Insert new admin
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO admins(name, email, password) VALUES(?,?,?)"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.executeUpdate();

            // Redirect to login page
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");

        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/jsp/register_admin.jsp").forward(request, response);
        }
    }
}

