package com.lostfound.servlet;

import com.lostfound.dao.ClaimDAO;
import com.lostfound.dao.ItemDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLoggedIn") == null) {
            response.sendRedirect(request.getContextPath() + "/adminLogin");
            return;
        }

        ItemDAO itemDAO = new ItemDAO();
        ClaimDAO claimDAO = new ClaimDAO();

        request.setAttribute("totalItems", itemDAO.getTotalItems());
        request.setAttribute("openItems", itemDAO.getOpenItems());
        request.setAttribute("resolvedItems", itemDAO.getResolvedItems());
        request.setAttribute("lostItems", itemDAO.getLostItemCount());
        request.setAttribute("foundItems", itemDAO.getFoundItemCount());
        request.setAttribute("pendingClaims", claimDAO.getPendingClaimCount());
        request.setAttribute("totalClaims", claimDAO.getTotalClaimCount());
        request.setAttribute("allClaims", claimDAO.getAllClaims());
        request.setAttribute("allItems", itemDAO.getAllItems(null, null, null));

        request.getRequestDispatcher("/jsp/admin/adminDashboard.jsp").forward(request, response);
    }
}
