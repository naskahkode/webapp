package com.app.web.controller;

import com.app.dao.CompanyDAO;
import com.app.model.Company;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class CompanyController extends HttpServlet {
    private final CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        
        if (path == null || "/".equals(path)) {
            try {
                loadList(req);
                req.getRequestDispatcher("/WEB-INF/views/company.jsp").forward(req, resp);
            } catch (SQLException e) {
                com.app.util.ErrorUtil.attachAndForward(req, resp, e, "Gagal memuat daftar company");
            }
        } else if (path.startsWith("/delete/")) {
            String idStr = path.substring(8); // Remove "/delete/"
            try {
                companyDAO.delete(Long.parseLong(idStr));
                com.app.util.Flash.success(req, "Company berhasil dihapus");
            } catch (SQLException e) {
                com.app.util.Flash.error(req, "Gagal menghapus company: " + e.getMessage());
            } catch (NumberFormatException e) {
                com.app.util.Flash.error(req, "ID tidak valid");
            }
            resp.sendRedirect(req.getContextPath() + "/company");
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/add".equals(path)) {
            handleAdd(req, resp);
        } else if (path != null && path.startsWith("/edit/")) {
            handleEdit(req, resp, path);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            com.app.util.Flash.error(req, "Nama company tidak boleh kosong");
            resp.sendRedirect(req.getContextPath() + "/company");
            return;
        }
        try {
            companyDAO.insert(new Company(null, name.trim()));
            com.app.util.Flash.success(req, "Company berhasil dibuat");
        } catch (SQLException e) {
            com.app.util.Flash.error(req, "Gagal menyimpan company: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/company");
    }

    private void handleEdit(HttpServletRequest req, HttpServletResponse resp, String path) throws IOException {
        String idStr = path.substring(6); // Remove "/edit/"
        String name = req.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            com.app.util.Flash.error(req, "Nama company tidak boleh kosong");
            resp.sendRedirect(req.getContextPath() + "/company");
            return;
        }
        try {
            Long id = Long.parseLong(idStr);
            companyDAO.update(new Company(id, name.trim()));
            com.app.util.Flash.success(req, "Company berhasil diperbarui");
        } catch (NumberFormatException e) {
            com.app.util.Flash.error(req, "ID tidak valid");
        } catch (SQLException e) {
            com.app.util.Flash.error(req, "Gagal memperbarui company: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/company");
    }

    private void loadList(HttpServletRequest req) throws SQLException {
        List<Company> companies = companyDAO.findAll();
        req.setAttribute("companies", companies);
    }
}