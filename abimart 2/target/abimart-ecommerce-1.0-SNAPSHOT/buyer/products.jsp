<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.abimart.dao.ProductDao" %>
<%@ page import="com.abimart.model.Product" %>
<%@ page import="java.util.List" %>
<%
    ProductDao.init(application.getResourceAsStream("/products.json"));
    ProductDao productDao = new ProductDao();
    String category = request.getParameter("category");
    String query = request.getParameter("q");
    List<Product> products;
    
    if (query != null && !query.isEmpty()) {
        products = productDao.searchProducts(query);
    } else if (category != null && !category.isEmpty()) {
        products = productDao.getProductsByCategory(category);
    } else {
        products = productDao.getAllProducts();
    }
%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop Products - ABIMART</title>
    <link rel="stylesheet" href="../css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <a href="../index.jsp" class="nav-brand">
            <i class="fa-solid fa-cube" style="color: var(--accent);"></i>
            ABIMART
        </a>
        
        <div class="search-bar">
            <form action="products.jsp" method="get">
                <i class="fa-solid fa-search search-icon"></i>
                <input type="text" name="search" placeholder="Search for premium products..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            </form>
        </div>

        <div class="nav-links">
            <a href="products.jsp" style="color: var(--text-primary);"><i class="fa-solid fa-store"></i> <span class="nav-text">Shop</span></a>
            <a href="cart.jsp" class="icon-btn">
                <i class="fa-solid fa-bag-shopping"></i>
                <span class="badge">0</span>
            </a>
            <a href="orders.jsp"><i class="fa-solid fa-box"></i> <span class="nav-text">Orders</span></a>
            <div style="width: 1px; height: 24px; background: var(--border-color); margin: 0 0.5rem;"></div>
            <a href="../chat.jsp"><i class="fa-solid fa-robot"></i></a>
            <a href="../auth?action=logout" class="btn btn-outline" style="padding: 0.5rem 1rem;">Logout</a>
        </div>
    </nav>

    <!-- Page Header -->
    <div style="background: var(--bg-secondary); padding: 3rem 5%; border-bottom: 1px solid var(--border-color);">
        <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">All Products</h1>
        <p class="text-secondary">Discover our collection of premium, high-quality items.</p>
    </div>

    <!-- Products Grid -->
    <section class="products-section" style="padding-top: 3rem;">
        <div class="container">
            <!-- Filter & Sort Bar -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; flex-wrap: wrap; gap: 1rem;">
                <div style="display: flex; gap: 1rem;">
                    <select class="form-control" style="width: auto; padding: 0.5rem 2rem 0.5rem 1rem; border-radius: var(--radius-full);">
                        <option>All Categories</option>
                        <option>Electronics</option>
                        <option>Fashion</option>
                    </select>
                    <select class="form-control" style="width: auto; padding: 0.5rem 2rem 0.5rem 1rem; border-radius: var(--radius-full);">
                        <option>Price: Any</option>
                        <option>Under $50</option>
                        <option>$50 - $200</option>
                        <option>Over $200</option>
                    </select>
                </div>
                <div style="display: flex; gap: 1rem; align-items: center;">
                    <span class="text-secondary text-sm">Sort by:</span>
                    <select class="form-control" style="width: auto; padding: 0.5rem 2rem 0.5rem 1rem; border-radius: var(--radius-full);">
                        <option>Recommended</option>
                        <option>Price: Low to High</option>
                        <option>Price: High to Low</option>
                        <option>Newest Arrivals</option>
                    </select>
                </div>
            </div>

            <div class="product-grid">
                <% if (products.isEmpty()) { %>
                    <div style="grid-column: 1 / -1; text-align: center; padding: 4rem;">
                        <h3>No products found.</h3>
                        <p>Try adjusting your search or filters.</p>
                    </div>
                <% } %>
                
                <% for (Product p : products) { %>
                <div class="product-card">
                    <% if (p.getDiscountPercentage() > 0) { %>
                    <div class="discount-badge"><%= String.format("%.0f", p.getDiscountPercentage()) %>% OFF</div>
                    <% } %>
                    <button class="wishlist-btn"><i class="fa-regular fa-heart"></i></button>
                    <a href="product-details.jsp?id=<%= p.getId() %>" style="display:block; text-decoration:none; color:inherit;">
                        <div class="product-image-container">
                            <img src="<%= p.getThumbnail() %>" alt="<%= p.getTitle().replace("\"", "&quot;") %>" class="product-image" style="object-fit: contain; padding: 1rem; background: #fff;">
                        </div>
                        <div class="product-info">
                            <div class="product-brand"><%= p.getBrand() != null ? p.getBrand() : "PREMIUM" %></div>
                            <h3 class="product-title"><%= p.getTitle() %></h3>
                            <div class="product-rating">
                                <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>
                                <span class="count">(<%= p.getRating() %>)</span>
                            </div>
                            <div class="price-block">
                                <span class="current-price">$<%= String.format("%.2f", p.getPrice()) %></span>
                                <% if (p.getDiscountPercentage() > 0) { %>
                                <span class="original-price">$<%= String.format("%.2f", p.getOriginalPrice()) %></span>
                                <% } %>
                            </div>
                        </div>
                    </a>
                    <form action="../CartServlet" method="post" class="add-to-cart-form">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="btn"><i class="fa-solid fa-cart-plus"></i> Add to Cart</button>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Premium Footer -->
    <footer>
        <div class="container">
            <div class="footer-bottom" style="border-top: none;">
                <p>&copy; 2026 ABIMART Inc. All rights reserved.</p>
            </div>
        </div>
    </footer>
</body>
</html>
