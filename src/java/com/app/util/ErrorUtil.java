package com.app.util;

import jakarta.servlet.http.HttpServletRequest;

public class ErrorUtil {
    public static void attachAndForward(HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp, Exception e, String contextMessage) throws jakarta.servlet.ServletException, java.io.IOException {
        req.setAttribute("errorMessage", contextMessage);
        req.setAttribute("errorType", e.getClass().getName());
        req.setAttribute("errorDetail", e.getMessage());
        req.setAttribute("requestURI", req.getRequestURI());
        req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
    }
}


