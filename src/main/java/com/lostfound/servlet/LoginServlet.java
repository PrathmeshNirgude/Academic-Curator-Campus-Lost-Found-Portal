package com.lostfound.servlet;

import com.lostfound.dao.UserDAO;
import com.lostfound.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String msg = request.getParameter("msg");
        if ("registered".equals(msg)) {
            request.setAttribute("success", "Registration successful! Please login.");
        }
        request.getRequestDispatcher("/jsp/user/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getName());
            response.sendRedirect(request.getContextPath() + "/items");
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/jsp/user/login.jsp").forward(request, response);
        }
    }
}
