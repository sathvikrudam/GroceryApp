package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AdminLogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect(request.getContextPath() + "/jsp/admin_login.jsp");
    }
}

