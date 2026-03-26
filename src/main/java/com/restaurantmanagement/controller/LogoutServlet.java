package com.restaurantmanagement.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

    	HttpSession session = req.getSession();
		session.removeAttribute("user");
		session.invalidate();
        res.sendRedirect("index.jsp");
    }
}
