package com.abimart.config;

import com.abimart.dao.ProductDao;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.InputStream;

@WebListener
public class AppStartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("ABIMART: Application starting, initializing Product Database...");
        InputStream is = sce.getServletContext().getResourceAsStream("/products.json");
        if (is != null) {
            ProductDao.init(is);
            System.out.println("ABIMART: Product Database initialized successfully.");
        } else {
            System.err.println("ABIMART ERROR: Could not find /products.json in ServletContext!");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
    }
}
