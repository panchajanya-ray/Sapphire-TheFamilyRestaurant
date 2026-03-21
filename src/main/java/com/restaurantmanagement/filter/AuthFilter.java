package com.restaurantmanagement.filter;

import com.restaurantmanagement.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({
        "/dashboard.jsp",
        "/menu",
        "/orders",
        "/reservations",
        "/invoice.jsp"
})
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpSession session = ((HttpServletRequest) request).getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        chain.doFilter(request, response);
    }
}
