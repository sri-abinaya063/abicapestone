<%@ page contentType="text/plain;charset=UTF-8" language="java" %>
<%@ page import="com.abimart.dao.ProductDao" %>
<%@ page import="com.abimart.model.Product" %>
<%@ page import="java.io.File" %>
<%
    try {
        ProductDao.init(application.getResourceAsStream("/products.json"));
        ProductDao dao = new ProductDao();
        int size = dao.getAllProducts().size();
        out.println("Products loaded: " + size);
        if (size > 0) {
            Product p = dao.getAllProducts().get(0);
            out.println("First product ID: " + p.getId());
            out.println("First product Name: " + p.getTitle());
        }
        File f = new File("C:/Users/ahame/Downloads/project/abimart 2/src/main/webapp/products.json");
        out.println("File exists: " + f.exists() + " Size: " + f.length());
    } catch (Throwable t) {
        t.printStackTrace(new java.io.PrintWriter(out));
    }
%>
