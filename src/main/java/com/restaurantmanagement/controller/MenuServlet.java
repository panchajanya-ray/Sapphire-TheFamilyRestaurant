package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.MenuItemDAO;
import com.restaurantmanagement.model.MenuItem;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        MenuItemDAO dao = new MenuItemDAO();
        List<MenuItem> items = dao.getAllItems();
        req.setAttribute("items", items);
        req.getRequestDispatcher("menu.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String category = req.getParameter("category");
        String priceStr = req.getParameter("price");
        String desc = req.getParameter("description");

        MenuItem m = new MenuItem();
        m.setItemName(name);
        m.setCategory(category);
        m.setPrice(Double.parseDouble(priceStr));
        m.setDescription(desc);
        m.setStatus("available");

        MenuItemDAO dao = new MenuItemDAO();
        dao.addMenuItem(m);

        res.sendRedirect("menu");
    }
}
