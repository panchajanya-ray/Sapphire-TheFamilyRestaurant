package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.MenuItemDAO;
import com.restaurantmanagement.dao.OrderDAO;
import com.restaurantmanagement.dao.OrderItemDAO;
import com.restaurantmanagement.model.InvoiceItem;
import com.restaurantmanagement.model.MenuItem;
import com.restaurantmanagement.model.Order;
import com.restaurantmanagement.model.OrderItem;
import com.restaurantmanagement.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.sql.Timestamp;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res)
	        throws ServletException, IOException {

	    HttpSession session = req.getSession(false);
	    if (session == null || session.getAttribute("user") == null) {
	        res.sendRedirect("index.jsp");
	        return;
	    }

	    User user = (User) session.getAttribute("user");
	    OrderDAO dao = new OrderDAO();

	    String dateParam = req.getParameter("date");
	    LocalDate date;

	    if (dateParam == null || dateParam.isEmpty()) {
	        date = LocalDate.now();
	    } else {
	        date = LocalDate.parse(dateParam);
	    }

	    req.setAttribute("selectedDate", date.toString());

	    // CUSTOMER → only his orders
	    if ("customer".equalsIgnoreCase(user.getRole())) {
	        List<Order> list = dao.getOrdersByUser(user.getId(),date);
	        req.setAttribute("orders", list);
	    }
	    // STAFF / ADMIN → date-wise orders
	    else {
	        List<Order> list = dao.getOrdersByDate(date);
	        req.setAttribute("orders", list);
	    }

	    req.setAttribute("orderCount",
	            ((List<?>) req.getAttribute("orders")).size());

	    req.setAttribute("menuItems", new MenuItemDAO().getAllItems());
	    req.getRequestDispatcher("orders.jsp").forward(req, res);
	}



    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession s = req.getSession(false);
        User u = (s != null) ? (User) s.getAttribute("user") : null;

        if (u == null) {
            res.sendRedirect("index.jsp");
            return;
        }

        String customerName = req.getParameter("customerName");

        String[] itemIds = req.getParameterValues("menuItemId");
        String[] quantities = req.getParameterValues("quantity");
        String[] prices = req.getParameterValues("price");
        String[] discounts = req.getParameterValues("discount");

        if (itemIds == null || quantities == null || prices == null || discounts == null) {
            res.sendRedirect("orders");
            return;
        }

        double orderTotal = 0.0;
        List<InvoiceItem> invoiceItems = new ArrayList<>();

        for (int i = 0; i < itemIds.length; i++) {
            int menuItemId = Integer.parseInt(itemIds[i]);
            int qty = Integer.parseInt(quantities[i]);
            double unitPrice = Double.parseDouble(prices[i]);
            double discountPercent = Double.parseDouble(discounts[i]);

            double subTotal = unitPrice * qty;
            double discountAmount = subTotal * (discountPercent / 100.0);
            double lineTotal = subTotal - discountAmount;

            orderTotal += lineTotal;

            InvoiceItem invoiceItem = new InvoiceItem();
            invoiceItem.setItemName(req.getParameter("itemName_" + i));
            invoiceItem.setQuantity(qty);
            invoiceItem.setUnitPrice(unitPrice);
            invoiceItem.setDiscountPercent(discountPercent);
            invoiceItem.setLineTotal(lineTotal);
            invoiceItems.add(invoiceItem);
        }

        Order order = new Order();
        order.setUserId(u.getId());
        order.setCustomerName(customerName);
        order.setTotalAmount(orderTotal);
        order.setStatus("pending");

        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.createOrder(order);

        OrderItemDAO itemDAO = new OrderItemDAO();

        for (int i = 0; i < itemIds.length; i++) {
            int menuItemId = Integer.parseInt(itemIds[i]);
            int qty = Integer.parseInt(quantities[i]);
            double unitPrice = Double.parseDouble(prices[i]);

            OrderItem oi = new OrderItem();
            oi.setOrderId(orderId);
            oi.setMenuItemId(menuItemId);
            oi.setQuantity(qty);
            oi.setPrice(unitPrice);

            itemDAO.addOrderItem(oi);
        }

        req.setAttribute("orderId", orderId);
        req.setAttribute("customerName", customerName);
        req.setAttribute("invoiceItems", invoiceItems);
        req.setAttribute("grandTotal", orderTotal);

        req.getRequestDispatcher("invoice.jsp").forward(req, res);
    }
}
