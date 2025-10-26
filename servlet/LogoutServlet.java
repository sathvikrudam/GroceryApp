package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // fetch existing session
        if (session != null) {
            session.invalidate(); // destroy session
        }
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp"); // redirect to login
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

