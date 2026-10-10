package com.abimart.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@WebServlet("/api/chatbot")
public class ChatbotServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        
        try {
            JsonObject jsonRequest = JsonParser.parseReader(req.getReader()).getAsJsonObject();
            String message = jsonRequest.get("message").getAsString().toLowerCase();
            
            String reply;
            if (message.contains("hello") || message.contains("hi")) {
                reply = "Hello! Welcome to ABIMART. How can I help you today?";
            } else if (message.contains("laptop") || message.contains("under")) {
                reply = "Here are some available laptops under your budget. Please check our electronics section.";
            } else if (message.contains("order")) {
                reply = "Please provide your order ID, and I can check the status for you.";
            } else {
                reply = "I'm an AI assistant. I can help you find products or check your order status.";
            }
            
            JsonObject responseJson = new JsonObject();
            responseJson.addProperty("reply", reply);
            out.print(responseJson.toString());
        } catch (Exception e) {
            JsonObject errorJson = new JsonObject();
            errorJson.addProperty("reply", "Sorry, I didn't understand that.");
            out.print(errorJson.toString());
        }
    }
}
