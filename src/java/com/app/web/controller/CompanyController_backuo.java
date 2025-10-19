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

public class CompanyController_backuo extends HttpServlet {
    private final CompanyDAO companyDAO = new CompanyDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || "/".equals(path) || "/list".equals(path)) {
            try {
                List<Company> companies = companyDAO.findAll();
                req.setAttribute("companies", companies);
                req.getRequestDispatcher("/WEB-INF/views/company.jsp").forward(req, resp);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        } else if (path.startsWith("/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                try {
                    Company c = companyDAO.findById(Long.parseLong(idStr));
                    req.setAttribute("company", c);
                    List<Company> companies = companyDAO.findAll();
                    req.setAttribute("companies", companies);
                    req.getRequestDispatcher("/WEB-INF/views/company.jsp").forward(req, resp);
                } catch (SQLException e) {
                    throw new ServletException(e);
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/company");
            }
        } else if (path.startsWith("/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                try {
                    companyDAO.delete(Long.parseLong(idStr));
                    resp.sendRedirect(req.getContextPath() + "/company");
                } catch (SQLException e) {
                    throw new ServletException(e);
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/company");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        if ("/save".equals(path)) {
            try {
                if (idStr == null || idStr.isEmpty()) {
                    Company c = new Company(null, name);
                    companyDAO.insert(c);
                } else {
                    Company c = new Company(Long.parseLong(idStr), name);
                    companyDAO.update(c);
                }
                resp.sendRedirect(req.getContextPath() + "/company");
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}


