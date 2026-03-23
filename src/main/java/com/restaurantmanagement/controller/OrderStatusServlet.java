package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.OrderDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateOrderStatus")
public class OrderStatusServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        OrderDAO dao = new OrderDAO();
        dao.updateStatus(id, "paid");

        res.sendRedirect("orders");
    }
}
