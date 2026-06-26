package com.lostfound.servlet;

import com.lostfound.dao.ItemDAO;
import com.lostfound.model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ItemListServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");
        String category = request.getParameter("category");
        String keyword = request.getParameter("keyword");

        ItemDAO itemDAO = new ItemDAO();
        List<Item> items = itemDAO.getAllItems(type, category, keyword);

        request.setAttribute("items", items);
        request.setAttribute("selectedType", type);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("keyword", keyword);

        String success = request.getParameter("success");
        if ("reported".equals(success)) {
            request.setAttribute("success", "Item reported successfully!");
        }
        request.getRequestDispatcher("/jsp/user/itemList.jsp").forward(request, response);
    }
}
