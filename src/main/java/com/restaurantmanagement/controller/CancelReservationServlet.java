package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.ReservationDAO;
import com.restaurantmanagement.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/cancelReservation")
public class CancelReservationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect("index.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int reservationId = Integer.parseInt(req.getParameter("id"));

        ReservationDAO dao = new ReservationDAO();
        
        if (user.getRole().equalsIgnoreCase("admin")|| user.getRole().equalsIgnoreCase("staff")) dao.deleteReservation(reservationId);
        if (dao.isOwner(reservationId, user.getId())) {
            dao.deleteReservation(reservationId);
        }
        
        res.sendRedirect("reservations");
    }
}
