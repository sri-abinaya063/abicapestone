package com.abimart.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("placeOrder".equals(action)) {
            // Mock order placement
            resp.sendRedirect("buyer/orders.jsp?orderPlaced=true");
        }
    }
}
