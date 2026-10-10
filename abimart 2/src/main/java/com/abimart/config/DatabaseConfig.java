package com.abimart.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.File;

public class DatabaseConfig {
    private static final String DB_PATH = System.getProperty("user.home") + File.separator + ".abimart" + File.separator + "abimart";
    private static final String URL = "jdbc:h2:" + DB_PATH + ";MODE=MySQL;DATABASE_TO_LOWER=TRUE;DEFAULT_NULL_ORDERING=HIGH;AUTO_SERVER=TRUE";
    private static final String USER = "sa";
    private static final String PASSWORD = "";

    static {
        try {
            File dbDir = new File(System.getProperty("user.home") + File.separator + ".abimart");
            if (!dbDir.exists()) {
                dbDir.mkdirs();
            }
        } catch (Exception e) {}
    }

    public static Connection getConnection() {
        try {
            Class.forName("org.h2.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error connecting to database: " + e.getMessage());
        }
    }
}
