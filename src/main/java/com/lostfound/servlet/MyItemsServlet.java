package com.lostfound.servlet;

import com.lostfound.dao.ItemDAO;
import com.lostfound.model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class MyItemsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        ItemDAO itemDAO = new ItemDAO();
        List<Item> items = itemDAO.getItemsByUser(userId);
        request.setAttribute("myItems", items);
        request.getRequestDispatcher("/jsp/user/myItems.jsp").forward(request, response);
    }
}
