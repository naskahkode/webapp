package com.app.util;

import jakarta.servlet.ServletContext;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static String dbUrl;
    private static String dbUsername;
    private static String dbPassword;
    private static String dbDriver;

    // Default to MySQL. Oracle example kept as comment for reference.
    // MySQL
    // Driver: com.mysql.cj.jdbc.Driver
    // URL: jdbc:mysql://localhost:3306/your_db?useSSL=false&serverTimezone=UTC
    // Oracle (reference)
    // Driver: oracle.jdbc.driver.OracleDriver
    // URL: jdbc:oracle:thin:@localhost:1521:xe

    public static void init(ServletContext context) {
        dbDriver = context.getInitParameter("DB_DRIVER");
        dbUrl = context.getInitParameter("DB_URL");
        dbUsername = context.getInitParameter("DB_USERNAME");
        dbPassword = context.getInitParameter("DB_PASSWORD");

        if (dbDriver == null || dbDriver.isEmpty()) {
//            dbDriver = "com.mysql.cj.jdbc.Driver";
            dbDriver = "oracle.jdbc.OracleDriver"; // Nama driver Oracle
        }
        if (dbUrl == null || dbUrl.isEmpty()) {
//            dbUrl = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC";
            dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";

        }
        try {
            Class.forName(dbDriver);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("JDBC Driver not found: " + dbDriver, e);
        }
    }

    public static Connection getConnection() throws SQLException {
        if (dbUrl == null) {
            throw new IllegalStateException("DBConnection not initialized. Call DBConnection.init(context) from a ContextListener.");
        }
        return DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
    }
}


