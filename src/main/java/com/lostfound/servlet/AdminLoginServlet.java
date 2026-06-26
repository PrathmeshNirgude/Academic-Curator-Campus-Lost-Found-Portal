package com.lostfound.servlet;

import com.lostfound.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class AdminLoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/admin/adminLogin.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();

        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        Connection con = null;
        try {
            con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("adminLoggedIn", true);
                session.setAttribute("adminUsername", username);
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } else {
                request.setAttribute("error", "Invalid admin credentials.");
                request.getRequestDispatcher("/jsp/admin/adminLogin.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error. Try again.");
            request.getRequestDispatcher("/jsp/admin/adminLogin.jsp").forward(request, response);
        } finally {
            DBConnection.closeConnection(con);
        }
    }
}
