package com.abimart.controller;

import com.abimart.dao.UserDao;
import com.abimart.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("login".equals(action)) {
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            User user = userDao.login(email, password);
            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                if(user.getRoleId() == 3) resp.sendRedirect("admin/dashboard.jsp");
                else if(user.getRoleId() == 2) resp.sendRedirect("seller/dashboard.jsp");
                else resp.sendRedirect("buyer/products.jsp");
            } else {
                resp.sendRedirect("login.jsp?error=invalid");
            }
        } else if ("register".equals(action)) {
            User user = new User();
            user.setFullName(req.getParameter("full_name"));
            user.setEmail(req.getParameter("email"));
            user.setMobile(req.getParameter("mobile"));
            user.setPasswordHash(req.getParameter("password"));
            user.setRoleId(Integer.parseInt(req.getParameter("role_id")));
            
            if (userDao.register(user)) {
                resp.sendRedirect("login.jsp?success=registered");
            } else {
                resp.sendRedirect("register.jsp?error=failed");
            }
        } else if ("logout".equals(action)) {
            req.getSession().invalidate();
            resp.sendRedirect("index.jsp");
        }
    }
}
