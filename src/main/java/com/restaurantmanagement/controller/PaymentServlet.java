package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.OrderDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String method = req.getParameter("method");
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String amount = req.getParameter("amount");

        OrderDAO dao = new OrderDAO();

        if ("counter".equals(method)) {

            dao.updatePayment(orderId, "counter", "pending");

            req.setAttribute("message", "Please pay at the counter.");
            req.getRequestDispatcher("paymentStatus.jsp").forward(req, res);

        } else if ("upi".equals(method)) {

            req.setAttribute("orderId", orderId);
            req.setAttribute("amount", amount);

            req.getRequestDispatcher("upiPayment.jsp").forward(req, res);
        }
    }
}