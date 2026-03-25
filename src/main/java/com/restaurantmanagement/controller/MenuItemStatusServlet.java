package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.MenuItemDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateAvailableStatus")
public class MenuItemStatusServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");

        MenuItemDAO dao = new MenuItemDAO();
        dao.updateStatus(id, status);

        res.sendRedirect("menu");
    }
}
