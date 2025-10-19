package com.app.web.listener;

import com.app.util.DBConnection;

import jakarta.servlet.ServletContext;

public class AppContextListener implements jakarta.servlet.ServletContextListener {
    @Override
    public void contextInitialized(jakarta.servlet.ServletContextEvent sce) {
        ServletContext ctx = sce.getServletContext();
        DBConnection.init(ctx);
    }

    @Override
    public void contextDestroyed(jakarta.servlet.ServletContextEvent sce) {}
}


