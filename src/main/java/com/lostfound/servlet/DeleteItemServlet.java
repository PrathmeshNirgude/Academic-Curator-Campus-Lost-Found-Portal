package com.lostfound.servlet;

import com.lostfound.dao.ItemDAO;
import com.lostfound.model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class DeleteItemServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/myItems");
            return;
        }

        int itemId = Integer.parseInt(idParam);
        int userId = (int) session.getAttribute("userId");
        ItemDAO itemDAO = new ItemDAO();
        Item item = itemDAO.getItemById(itemId);

        // Only allow owner to delete
        if (item != null && item.getUserId() == userId) {
            itemDAO.deleteItem(itemId);
        }

        response.sendRedirect(request.getContextPath() + "/myItems");
    }
}
