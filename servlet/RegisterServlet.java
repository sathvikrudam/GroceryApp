package servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import db.DBConnection;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // user or admin

        try (Connection con = DBConnection.getConnection()) {

            // Check if email already exists
            PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE email=?");
            check.setString(1, email);
            ResultSet rs = check.executeQuery();
            if(rs.next()) {
                request.setAttribute("errorMsg", "Email already registered!");
                request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
                return;
            }

            // Insert new user/admin
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(name, email, password, role) VALUES(?,?,?,?)"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);
            ps.executeUpdate();

            // Redirect to login
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");

        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
}
