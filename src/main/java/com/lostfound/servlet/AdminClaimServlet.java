package com.lostfound.servlet;

import com.lostfound.dao.ClaimDAO;
import com.lostfound.dao.ItemDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AdminClaimServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLoggedIn") == null) {
            response.sendRedirect(request.getContextPath() + "/adminLogin");
            return;
        }

        String action = request.getParameter("action");
        String claimIdStr = request.getParameter("claimId");
        String itemIdStr = request.getParameter("itemId");

        if (action != null && claimIdStr != null) {
            int claimId = Integer.parseInt(claimIdStr);
            ClaimDAO claimDAO = new ClaimDAO();
            ItemDAO itemDAO = new ItemDAO();

            if ("approve".equals(action)) {
                claimDAO.updateClaimStatus(claimId, "approved");
                // Mark the item as resolved
                if (itemIdStr != null) {
                    itemDAO.updateItemStatus(Integer.parseInt(itemIdStr), "resolved");
                }
            } else if ("reject".equals(action)) {
                claimDAO.updateClaimStatus(claimId, "rejected");
            }
        }

        response.sendRedirect(request.getContextPath() + "/adminDashboard");
    }
}
