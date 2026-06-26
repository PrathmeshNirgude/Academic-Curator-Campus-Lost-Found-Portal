package com.lostfound.servlet;

import com.lostfound.dao.ClaimDAO;
import com.lostfound.dao.ItemDAO;
import com.lostfound.model.Claim;
import com.lostfound.model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class ItemDetailServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/items");
            return;
        }

        int itemId = Integer.parseInt(idParam);
        ItemDAO itemDAO = new ItemDAO();
        ClaimDAO claimDAO = new ClaimDAO();

        Item item = itemDAO.getItemById(itemId);
        List<Claim> claims = claimDAO.getClaimsByItem(itemId);

        request.setAttribute("item", item);
        request.setAttribute("claims", claims);

        // Check if logged-in user already claimed
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userId") != null) {
            int userId = (int) session.getAttribute("userId");
            boolean alreadyClaimed = claimDAO.alreadyClaimed(itemId, userId);
            request.setAttribute("alreadyClaimed", alreadyClaimed);
            request.setAttribute("isOwner", item != null && item.getUserId() == userId);
        }

        String msg = request.getParameter("msg");
        if ("claimed".equals(msg)) request.setAttribute("success", "Claim submitted successfully!");

        request.getRequestDispatcher("/jsp/user/itemDetail.jsp").forward(request, response);
    }
}
