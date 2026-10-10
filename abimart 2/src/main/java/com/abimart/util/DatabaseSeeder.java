package com.abimart.util;

import com.abimart.config.DatabaseConfig;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.Statement;

public class DatabaseSeeder {

    public static void main(String[] args) {
        System.out.println("Starting Database Seeder...");
        String basePath = "C:/Users/ahame/Downloads/project/abimart 2/database/";
        
        try (Connection conn = DatabaseConfig.getConnection()) {
            executeSqlFile(conn, basePath + "schema.sql");
            executeSqlFile(conn, basePath + "seed.sql");
            System.out.println("Database seeding completed successfully.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void executeSqlFile(Connection conn, String filePath) throws Exception {
        System.out.println("Executing " + filePath + "...");
        File file = new File(filePath);
        if (!file.exists()) {
            System.err.println("File not found: " + filePath);
            return;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file));
             Statement stmt = conn.createStatement()) {
            
            StringBuilder sql = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                line = line.trim();
                // Skip empty lines and single-line comments
                if (line.isEmpty() || line.startsWith("--")) {
                    continue;
                }
                
                sql.append(line).append(" ");
                
                // If it's the end of a statement
                if (line.endsWith(";")) {
                    try {
                        stmt.execute(sql.toString());
                    } catch (Exception e) {
                        System.err.println("Failed to execute: " + sql.toString());
                        System.err.println("Error: " + e.getMessage());
                    }
                    sql.setLength(0);
                }
            }
        }
    }
}
