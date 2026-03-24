package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.OrderDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/paymentResult")
public class PaymentResultServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String status = req.getParameter("status");
        int orderId = Integer.parseInt(req.getParameter("orderId"));

        OrderDAO dao = new OrderDAO();

        if ("success".equals(status)) {
            dao.updatePayment(orderId, "upi", "paid");
            req.setAttribute("status", "success");

        } else {
            dao.updatePayment(orderId, "upi", "failed");
            req.setAttribute("status", "failed");
        }

        req.getRequestDispatcher("paymentStatus.jsp").forward(req, res);
    }
}