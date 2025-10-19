package com.app.web.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
@WebServlet(urlPatterns = {"", "/index"})
public class HomeController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //bisa langsung ke dashboard.jsp
        // req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(req, resp);

        // ataur menggunakan layout dashboard.jsp
        req.setAttribute("pageTitle", "Hoempage List");
        req.setAttribute("contentPage", "/index.jsp");
        req.getRequestDispatcher("/WEB-INF/layouts/homepage.jsp")
            .forward(req, resp);
    }
}


