package com.restaurantmanagement.controller;

import com.restaurantmanagement.dao.UserDAO;
import com.restaurantmanagement.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = new User();
        user.setName(name);
        user.setUsername(username);
        user.setPassword(password);
        user.setRole("customer");

        UserDAO dao = new UserDAO();
        dao.addUser(user);

        res.sendRedirect("index.jsp?signup=success");
    }
}
