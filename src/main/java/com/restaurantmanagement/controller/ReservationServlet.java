package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.ReservationDAO;
import com.restaurantmanagement.model.User;
import com.restaurantmanagement.model.Reservation;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

@WebServlet("/reservations")
public class ReservationServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
	        throws ServletException, IOException {

	    HttpSession session = req.getSession(false);
	    if (session == null || session.getAttribute("user") == null) {
	        res.sendRedirect("index.jsp");
	        return;
	    }

	    User user = (User) session.getAttribute("user");
	    ReservationDAO dao = new ReservationDAO();

	    String dateParam = req.getParameter("date");
	    Date date;

	    if (dateParam == null || dateParam.isEmpty()) {
	        date = new Date(System.currentTimeMillis()); // today
	    } else {
	        date = Date.valueOf(dateParam);
	    }

	    req.setAttribute("selectedDate", date.toString());

	    // CUSTOMER → only form
	    if ("customer".equalsIgnoreCase(user.getRole())) {
	    	List<Reservation> list = dao.getReservationsByUser(user.getId(),date);

		    req.setAttribute("reservations", list);
		    req.setAttribute("selectedDate", date.toString());
		    req.setAttribute("reservationCount", list.size());
	        req.getRequestDispatcher("reservations.jsp").forward(req, res);
	        return;
	    }

	    // STAFF / ADMIN → date filtered list
	    List<Reservation> list = dao.getByDate(date);

	    req.setAttribute("reservations", list);
	    req.setAttribute("selectedDate", date.toString());
	    req.setAttribute("reservationCount", list.size());

	    req.getRequestDispatcher("reservations.jsp").forward(req, res);

	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res)
	        throws ServletException, IOException {

	    User user = (User) req.getSession().getAttribute("user");

	    String name = req.getParameter("customerName");
	    String phone = req.getParameter("phone");
	    String dateStr = req.getParameter("date");
	    String timeStr = req.getParameter("time");
	    String peopleStr = req.getParameter("people");

	    Reservation r = new Reservation();
	    r.setCustomerName(name);
	    r.setPhone(phone);
	    r.setReservationDate(Date.valueOf(dateStr));
	    r.setReservationTime(Time.valueOf(timeStr + ":00"));
	    r.setPeople(Integer.parseInt(peopleStr));
	    r.setStatus("confirmed");
	    r.setUserId(user.getId());  // <-- REQUIRED

	    ReservationDAO dao = new ReservationDAO();
	    dao.addReservation(r);

	    res.sendRedirect("reservations");
	}

}
