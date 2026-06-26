package com.lostfound.servlet;

import com.lostfound.dao.ItemDAO;
import com.lostfound.model.Item;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.Date;

@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max
public class ReportItemServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/jsp/user/reportItem.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String type = request.getParameter("type");
        String title = request.getParameter("title").trim();
        String description = request.getParameter("description").trim();
        String category = request.getParameter("category");
        String location = request.getParameter("location").trim();
        String dateStr = request.getParameter("dateReported");

        if (title.isEmpty() || location.isEmpty() || dateStr.isEmpty()) {
            request.setAttribute("error", "Please fill all required fields.");
            request.getRequestDispatcher("/jsp/user/reportItem.jsp").forward(request, response);
            return;
        }

        Item item = new Item();
        item.setUserId(userId);
        item.setType(type);
        item.setTitle(title);
        item.setDescription(description);
        item.setCategory(category);
        item.setLocation(location);
        item.setDateReported(Date.valueOf(dateStr));

        ItemDAO itemDAO = new ItemDAO();
        int itemId = itemDAO.addItem(item);

        if (itemId > 0) {
            // Handle file upload
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = java.util.UUID.randomUUID().toString() + "_" + getFileName(filePart);
                String uploadPath = "E:\\program\\Lost and Found\\uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                try (InputStream is = filePart.getInputStream();
                     FileOutputStream fos = new FileOutputStream(new File(uploadPath, fileName))) {
                    byte[] buf = new byte[4096];
                    int len;
                    while ((len = is.read(buf)) != -1) fos.write(buf, 0, len);
                }
                itemDAO.addItemImage(itemId, fileName);
            }
            response.sendRedirect(request.getContextPath() + "/items?success=reported");
        } else {
            request.setAttribute("error", "Failed to report item. Try again.");
            request.getRequestDispatcher("/jsp/user/reportItem.jsp").forward(request, response);
        }
    }

    private String getFileName(Part part) {
        String header = part.getHeader("content-disposition");
        for (String token : header.split(";")) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "file_" + System.currentTimeMillis();
    }
}
