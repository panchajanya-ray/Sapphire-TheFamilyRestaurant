package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.UserDAO;
import com.restaurantmanagement.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String u = req.getParameter("username");
        String p = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(u, p);

        if (user == null) {
            res.sendRedirect("index.jsp?error=1");
        } else {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            if ("admin".equalsIgnoreCase(user.getRole()))
                res.sendRedirect("dashboard.jsp");
            else
                res.sendRedirect("dashboard.jsp");
        }
    }
}
