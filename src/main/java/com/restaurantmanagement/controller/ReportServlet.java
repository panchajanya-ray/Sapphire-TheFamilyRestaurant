package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.ReportDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        ReportDAO dao = new ReportDAO();

        req.setAttribute("ordersDay", dao.ordersDay());
        req.setAttribute("ordersMonth", dao.ordersMonth());
        req.setAttribute("ordersYear", dao.ordersYear());

        req.setAttribute("resDay", dao.reservationsDay());
        req.setAttribute("resMonth", dao.reservationsMonth());
        req.setAttribute("resYear", dao.reservationsYear());

        req.getRequestDispatcher("reports.jsp").forward(req, res);
    }
}

