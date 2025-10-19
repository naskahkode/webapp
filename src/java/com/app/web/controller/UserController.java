package com.app.web.controller;

import com.app.dao.UserDAO;
import com.app.model.User;
import com.app.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class UserController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if (path == null || "/".equals(path) || "/list".equals(path)) {
            try {
                List<User> users = userDAO.findAll();
                req.setAttribute("users", users);
                req.getRequestDispatcher("/WEB-INF/views/user.jsp").forward(req, resp);
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        } else if (path.startsWith("/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                try {
                    User u = userDAO.findById(Long.parseLong(idStr));
                    req.setAttribute("userForm", u);
                    List<User> users = userDAO.findAll();
                    req.setAttribute("users", users);
                    req.getRequestDispatcher("/WEB-INF/views/user.jsp").forward(req, resp);
                } catch (SQLException e) {
                    throw new ServletException(e);
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/user");
            }
        } else if (path.startsWith("/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                try {
                    userDAO.delete(Long.parseLong(idStr));
                    resp.sendRedirect(req.getContextPath() + "/user");
                } catch (SQLException e) {
                    throw new ServletException(e);
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/user");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/save".equals(path)) {
            String idStr = req.getParameter("id");
            String name = req.getParameter("name");
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String roleIdStr = req.getParameter("roleId");
            int roleId = Integer.parseInt(roleIdStr);
            try {
                if (idStr == null || idStr.isEmpty()) {
                    User u = new User(null, name, username, authService.sha256(password), roleId);
                    userDAO.insert(u);
                } else {
                    User u = new User(Long.parseLong(idStr), name, username, authService.sha256(password), roleId);
                    userDAO.update(u);
                }
                resp.sendRedirect(req.getContextPath() + "/user");
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}


