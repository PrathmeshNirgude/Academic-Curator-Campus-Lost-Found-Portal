package com.lostfound.servlet;

import com.lostfound.dao.ClaimDAO;
import com.lostfound.model.Claim;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class ClaimServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int itemId = Integer.parseInt(request.getParameter("itemId"));
        int claimantId = (int) session.getAttribute("userId");
        String proof = request.getParameter("proofDescription");

        ClaimDAO claimDAO = new ClaimDAO();
        if (claimDAO.alreadyClaimed(itemId, claimantId)) {
            response.sendRedirect(request.getContextPath() + "/itemDetail?id=" + itemId + "&msg=already");
            return;
        }

        Claim claim = new Claim();
        claim.setItemId(itemId);
        claim.setClaimantId(claimantId);
        claim.setProofDescription(proof);

        if (claimDAO.addClaim(claim)) {
            response.sendRedirect(request.getContextPath() + "/itemDetail?id=" + itemId + "&msg=claimed");
        } else {
            response.sendRedirect(request.getContextPath() + "/itemDetail?id=" + itemId + "&msg=error");
        }
    }
}
