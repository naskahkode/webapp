package com.app.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class Flash {
    public static void success(HttpServletRequest req, String message) {
        HttpSession session = req.getSession(true);
        session.setAttribute("flash_success", message);
    }

    public static void error(HttpServletRequest req, String message) {
        HttpSession session = req.getSession(true);
        session.setAttribute("flash_error", message);
    }
}


