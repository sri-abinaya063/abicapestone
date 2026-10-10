<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.abimart.dao.ProductDao" %>
<%@ page import="com.abimart.model.Product" %>
<%@ page import="java.util.List" %>
    <%
        List<Product> featuredProducts = null;
        List<Product> topDeals = null;
        List<Product> trendingProducts = null;
        List<Product> newArrivals = null;
        try {
            ProductDao productDao = new ProductDao();
            featuredProducts = productDao.getFeaturedProducts(8);
            topDeals = productDao.getTopDeals(8);
            trendingProducts = productDao.getTrendingProducts(8);
            newArrivals = productDao.getNewArrivals(8);
        } catch (Exception e) {}
    %>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABIMART | Premium E-Commerce</title>
    <!-- Use the new premium CSS -->
    <link rel="stylesheet" href="css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <a href="index.jsp" class="nav-brand">
            <!-- Using text logo for premium feel if image is basic -->
            <i class="fa-solid fa-cube" style="color: var(--accent);"></i>
            ABIMART
        </a>
        
        <div class="search-bar">
            <form action="buyer/products.jsp" method="get">
                <i class="fa-solid fa-search search-icon"></i>
                <input type="text" name="q" placeholder="Search for premium products...">
            </form>
        </div>

        <div class="nav-links">
            <a href="buyer/products.jsp"><i class="fa-solid fa-store"></i> <span class="nav-text">Shop</span></a>
            <a href="buyer/cart.jsp" class="icon-btn">
                <i class="fa-solid fa-bag-shopping"></i>
                <span class="badge">0</span>
            </a>
            <a href="login.jsp" class="btn btn-outline" style="padding: 0.5rem 1rem;">Sign In</a>
            <a href="register.jsp" class="btn btn-primary" style="padding: 0.5rem 1rem;">Join Now</a>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">
            <div class="hero-badge">
                <span>NEW</span> Discover the Fall Collection
            </div>
            <h1>SHOP SMARTER.<br>LIVE BETTER.</h1>
            <p>Discover a curated collection of premium products designed for your everyday life. Experience the future of online shopping.</p>
            <div class="hero-actions">
                <a href="buyer/products.jsp" class="btn btn-primary"><i class="fa-solid fa-compass"></i> Explore Products</a>
                <a href="#deals" class="btn btn-outline">View Deals</a>
            </div>
        </div>
        <div class="hero-visual">
            <img src="images/hero_banner.jpg" alt="Premium E-Commerce Experience" class="hero-image">
        </div>
    </section>

    <!-- Categories Section -->
    <section class="categories-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Shop by Category</h2>
                <a href="buyer/products.jsp" class="btn btn-outline">View All <i class="fa-solid fa-arrow-right"></i></a>
            </div>
            <div class="categories-grid">
                <div class="category-card" onclick="location.href='buyer/products.jsp?category=Electronics'">
                    <i class="fa-solid fa-laptop category-icon"></i>
                    <div class="category-name">Electronics</div>
                    <div class="category-count">124 Products</div>
                </div>
                <div class="category-card" onclick="location.href='buyer/products.jsp?category=Fashion'">
                    <i class="fa-solid fa-shirt category-icon"></i>
                    <div class="category-name">Fashion</div>
                    <div class="category-count">86 Products</div>
                </div>
                <div class="category-card" onclick="location.href='buyer/products.jsp?category=Home'">
                    <i class="fa-solid fa-couch category-icon"></i>
                    <div class="category-name">Home & Living</div>
                    <div class="category-count">52 Products</div>
                </div>
                <div class="category-card" onclick="location.href='buyer/products.jsp?category=Beauty'">
                    <i class="fa-solid fa-spray-can-sparkles category-icon"></i>
                    <div class="category-name">Beauty</div>
                    <div class="category-count">43 Products</div>
                </div>
                <div class="category-card" onclick="location.href='buyer/products.jsp?category=Sports'">
                    <i class="fa-solid fa-dumbbell category-icon"></i>
                    <div class="category-name">Sports</div>
                    <div class="category-count">38 Products</div>
                </div>
                <div class="category-card" onclick="location.href='buyer/products.jsp?category=Accessories'">
                    <i class="fa-solid fa-headphones category-icon"></i>
                    <div class="category-name">Accessories</div>
                    <div class="category-count">95 Products</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Products Section -->
    <section class="products-section" id="deals">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Featured Products</h2>
            </div>
            <div class="product-grid">
                <% for (Product p : featuredProducts) { %>
                <div class="product-card">
                    <% if (p.getDiscountPercentage() > 0) { %>
                    <div class="discount-badge"><%= String.format("%.0f", p.getDiscountPercentage()) %>% OFF</div>
                    <% } %>
                    <button class="wishlist-btn"><i class="fa-regular fa-heart"></i></button>
                    <a href="buyer/product-details.jsp?id=<%= p.getId() %>" style="display:block; text-decoration:none; color:inherit;">
                        <div class="product-image-container">
                            <img src="<%= p.getThumbnail() %>" alt="<%= p.getTitle().replace("\"", "&quot;") %>" class="product-image">
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
                    <form action="CartServlet" method="post" class="add-to-cart-form">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="btn"><i class="fa-solid fa-cart-plus"></i> Add to Cart</button>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Top Deals Section -->
    <section class="products-section" style="background: var(--surface); margin: 2rem 0;">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Top Deals</h2>
            </div>
            <div class="product-grid">
                <% for (Product p : topDeals) { %>
                <div class="product-card">
                    <% if (p.getDiscountPercentage() > 0) { %>
                    <div class="discount-badge"><%= String.format("%.0f", p.getDiscountPercentage()) %>% OFF</div>
                    <% } %>
                    <button class="wishlist-btn"><i class="fa-regular fa-heart"></i></button>
                    <a href="buyer/product-details.jsp?id=<%= p.getId() %>" style="display:block; text-decoration:none; color:inherit;">
                        <div class="product-image-container">
                            <img src="<%= p.getThumbnail() %>" alt="<%= p.getTitle().replace("\"", "&quot;") %>" class="product-image" loading="lazy">
                        </div>
                        <div class="product-info">
                            <div class="product-brand"><%= p.getBrand() != null && !p.getBrand().isEmpty() ? p.getBrand() : "PREMIUM" %></div>
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
                    <form action="CartServlet" method="post" class="add-to-cart-form">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="btn"><i class="fa-solid fa-cart-plus"></i> Add to Cart</button>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Trending Products Section -->
    <section class="products-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Trending Products</h2>
            </div>
            <div class="product-grid">
                <% for (Product p : trendingProducts) { %>
                <div class="product-card">
                    <% if (p.getDiscountPercentage() > 0) { %>
                    <div class="discount-badge"><%= String.format("%.0f", p.getDiscountPercentage()) %>% OFF</div>
                    <% } %>
                    <button class="wishlist-btn"><i class="fa-regular fa-heart"></i></button>
                    <a href="buyer/product-details.jsp?id=<%= p.getId() %>" style="display:block; text-decoration:none; color:inherit;">
                        <div class="product-image-container">
                            <img src="<%= p.getThumbnail() %>" alt="<%= p.getTitle().replace("\"", "&quot;") %>" class="product-image" loading="lazy">
                        </div>
                        <div class="product-info">
                            <div class="product-brand"><%= p.getBrand() != null && !p.getBrand().isEmpty() ? p.getBrand() : "PREMIUM" %></div>
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
                    <form action="CartServlet" method="post" class="add-to-cart-form">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="btn"><i class="fa-solid fa-cart-plus"></i> Add to Cart</button>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- New Arrivals Section -->
    <section class="products-section" style="background: var(--surface); margin: 2rem 0;">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">New Arrivals</h2>
            </div>
            <div class="product-grid">
                <% for (Product p : newArrivals) { %>
                <div class="product-card">
                    <% if (p.getDiscountPercentage() > 0) { %>
                    <div class="discount-badge"><%= String.format("%.0f", p.getDiscountPercentage()) %>% OFF</div>
                    <% } %>
                    <button class="wishlist-btn"><i class="fa-regular fa-heart"></i></button>
                    <a href="buyer/product-details.jsp?id=<%= p.getId() %>" style="display:block; text-decoration:none; color:inherit;">
                        <div class="product-image-container">
                            <img src="<%= p.getThumbnail() %>" alt="<%= p.getTitle().replace("\"", "&quot;") %>" class="product-image" loading="lazy">
                        </div>
                        <div class="product-info">
                            <div class="product-brand"><%= p.getBrand() != null && !p.getBrand().isEmpty() ? p.getBrand() : "PREMIUM" %></div>
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
                    <form action="CartServlet" method="post" class="add-to-cart-form">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= p.getId() %>">
                        <button type="submit" class="btn"><i class="fa-solid fa-cart-plus"></i> Add to Cart</button>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Chatbot Floating Button -->
    <button class="chatbot-btn" onclick="location.href='chat.jsp'">
        <i class="fa-solid fa-robot"></i>
    </button>

    <!-- Premium Footer -->
    <footer>
        <div class="container">
            <div class="footer-content">
                <div class="footer-brand">
                    <h2><i class="fa-solid fa-cube" style="color: var(--accent);"></i> ABIMART</h2>
                    <p>The premier destination for high-quality products, fast delivery, and exceptional customer service.</p>
                </div>
                <div class="footer-links">
                    <div class="footer-col">
                        <h4>Shop</h4>
                        <ul>
                            <li><a href="buyer/products.jsp?category=Electronics">Electronics</a></li>
                            <li><a href="buyer/products.jsp?category=Fashion">Fashion</a></li>
                            <li><a href="buyer/products.jsp?category=Home">Home & Living</a></li>
                            <li><a href="#deals">Today's Deals</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h4>Support</h4>
                        <ul>
                            <li><a href="#">Help Center</a></li>
                            <li><a href="#">Track Order</a></li>
                            <li><a href="#">Returns & Refunds</a></li>
                            <li><a href="#">Contact Us</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h4>Company</h4>
                        <ul>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Careers</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="#">Terms of Service</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 ABIMART Inc. All rights reserved.</p>
                <div class="social-links">
                    <a href="#" style="margin-left: 1rem;"><i class="fa-brands fa-twitter"></i></a>
                    <a href="#" style="margin-left: 1rem;"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" style="margin-left: 1rem;"><i class="fa-brands fa-youtube"></i></a>
                </div>
            </div>
        </div>
    </footer>
</body>
</html>
