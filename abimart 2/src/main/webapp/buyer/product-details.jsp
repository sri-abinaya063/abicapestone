<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.abimart.dao.ProductDao" %>
<%@ page import="com.abimart.model.Product" %>
<%@ page import="java.util.List" %>
<%
    ProductDao.init(application.getResourceAsStream("/products.json"));
    String productId = request.getParameter("id");
    
    ProductDao productDao = new ProductDao();
    Product product = productDao.getProductById(productId);
    
    if (product == null) {
        response.sendRedirect("products.jsp");
        return;
    }
    
    List<Product> relatedProducts = productDao.getProductsByCategory(product.getMappedCategory());
    if (relatedProducts.size() > 4) {
        relatedProducts = relatedProducts.subList(0, 4);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getTitle() %> - ABIMART</title>
    <link rel="stylesheet" href="../css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .details-container { display: flex; gap: 4rem; padding: 4rem 5%; background: var(--bg-main); }
        .details-gallery { flex: 1; }
        .details-info { flex: 1; }
        .main-image { width: 100%; aspect-ratio: 1; object-fit: contain; background: var(--bg-secondary); border-radius: var(--radius-lg); margin-bottom: 1rem; border: 1px solid var(--border-color); padding: 2rem;}
        .thumbnail-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 1rem; }
        .thumbnail { width: 100%; aspect-ratio: 1; object-fit: contain; background: var(--bg-secondary); border-radius: var(--radius-sm); cursor: pointer; border: 2px solid transparent; padding: 0.5rem;}
        .thumbnail:hover, .thumbnail.active { border-color: var(--accent); }
        .details-brand { font-weight: 600; color: var(--accent); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 1rem; display: inline-block;}
        .details-title { font-size: 2.5rem; color: var(--text-primary); margin-bottom: 1rem; line-height: 1.2;}
        .details-rating { display: flex; align-items: center; gap: 1rem; margin-bottom: 2rem; color: var(--warning); }
        .details-price { display: flex; align-items: baseline; gap: 1rem; margin-bottom: 2rem; }
        .details-price .current { font-size: 2.5rem; font-weight: 700; color: var(--text-primary); }
        .details-price .original { font-size: 1.25rem; color: var(--text-muted); text-decoration: line-through; }
        .details-price .discount { background: var(--error); color: white; padding: 0.25rem 0.75rem; border-radius: var(--radius-full); font-weight: 600; font-size: 0.9rem;}
        .details-desc { font-size: 1.1rem; color: var(--text-secondary); margin-bottom: 2rem; line-height: 1.8; }
        .action-row { display: flex; gap: 1rem; margin-bottom: 3rem; }
        .quantity-selector { display: flex; border: 1px solid var(--border-color); border-radius: var(--radius-full); overflow: hidden; background: var(--bg-secondary); }
        .qty-btn { padding: 0.75rem 1.25rem; background: none; border: none; cursor: pointer; font-size: 1.2rem; color: var(--text-primary); transition: all 0.2s;}
        .qty-btn:hover { background: var(--border-color); }
        .qty-input { width: 60px; text-align: center; border: none; background: none; font-size: 1.1rem; font-weight: 600; }
        .specs-table { width: 100%; border-collapse: collapse; }
        .specs-table tr { border-bottom: 1px solid var(--border-color); }
        .specs-table th { text-align: left; padding: 1rem 0; color: var(--text-secondary); font-weight: 500; width: 40%;}
        .specs-table td { text-align: right; padding: 1rem 0; font-weight: 600; color: var(--text-primary); }
        
        @media (max-width: 768px) {
            .details-container { flex-direction: column; gap: 2rem; }
            .details-title { font-size: 2rem; }
        }
    </style>
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
                <input type="text" name="q" placeholder="Search for premium products...">
            </form>
        </div>

        <div class="nav-links">
            <a href="products.jsp"><i class="fa-solid fa-store"></i> <span class="nav-text">Shop</span></a>
            <a href="cart.jsp" class="icon-btn">
                <i class="fa-solid fa-bag-shopping"></i>
                <span class="badge">0</span>
            </a>
            <div style="width: 1px; height: 24px; background: var(--border-color); margin: 0 0.5rem;"></div>
            <a href="../chat.jsp"><i class="fa-solid fa-robot"></i></a>
        </div>
    </nav>

    <!-- Product Details -->
    <div class="details-container">
        <!-- Gallery -->
        <div class="details-gallery">
            <img id="mainImage" src="<%= product.getImages() != null && !product.getImages().isEmpty() ? product.getImages().get(0) : product.getThumbnail() %>" alt="<%= product.getTitle().replace("\"", "&quot;") %>" class="main-image">
            <div class="thumbnail-grid">
                <% if (product.getImages() != null) {
                    for (int i=0; i < product.getImages().size(); i++) {
                        String img = product.getImages().get(i);
                %>
                <img src="<%= img %>" class="thumbnail <%= i==0 ? "active" : "" %>" onclick="changeImage(this, '<%= img %>')">
                <%  } 
                } %>
            </div>
        </div>

        <!-- Info -->
        <div class="details-info">
            <div class="details-brand"><%= product.getBrand() != null ? product.getBrand() : "PREMIUM" %></div>
            <h1 class="details-title"><%= product.getTitle() %></h1>
            <div class="details-rating">
                <div>
                    <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>
                </div>
                <span><%= product.getRating() %> Rating</span>
                <span style="color: var(--border-color);">|</span>
                <span style="color: var(--success);"><i class="fa-solid fa-check-circle"></i> In Stock (<%= product.getStock() %>)</span>
            </div>
            
            <div class="details-price">
                <span class="current">$<%= String.format("%.2f", product.getPrice()) %></span>
                <% if (product.getDiscountPercentage() > 0) { %>
                <span class="original">$<%= String.format("%.2f", product.getOriginalPrice()) %></span>
                <span class="discount"><%= String.format("%.0f", product.getDiscountPercentage()) %>% OFF</span>
                <% } %>
            </div>
            
            <p class="details-desc"><%= product.getDescription() %></p>
            
            <form action="../CartServlet" method="post" class="action-row">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="productId" value="<%= product.getId() %>">
                <div class="quantity-selector">
                    <button type="button" class="qty-btn" onclick="let input = document.getElementById('qty'); input.value = Math.max(1, parseInt(input.value)-1);">-</button>
                    <input type="number" id="qty" name="quantity" class="qty-input" value="1" min="1" max="<%= product.getStock() %>">
                    <button type="button" class="qty-btn" onclick="let input = document.getElementById('qty'); input.value = Math.min(<%= product.getStock() %>, parseInt(input.value)+1);">+</button>
                </div>
                <button type="submit" class="btn btn-primary" style="flex: 1;"><i class="fa-solid fa-cart-plus"></i> Add to Cart</button>
                <button type="button" class="btn btn-outline" style="padding: 0 1.25rem;"><i class="fa-regular fa-heart"></i></button>
            </form>
            
            <!-- Specifications -->
            <h3 style="margin-bottom: 1rem;">Specifications</h3>
            <table class="specs-table">
                <tr>
                    <th>Category</th>
                    <td><%= product.getCategory().substring(0, 1).toUpperCase() + product.getCategory().substring(1) %></td>
                </tr>
                <tr>
                    <th>Brand</th>
                    <td><%= product.getBrand() != null ? product.getBrand() : "Generic" %></td>
                </tr>
                <tr>
                    <th>Availability</th>
                    <td>Ships within 24 hours</td>
                </tr>
            </table>
        </div>
    </div>

    <!-- Related Products -->
    <section class="products-section" style="padding-top: 2rem;">
        <div class="container">
            <h2 class="section-title" style="margin-bottom: 3rem; text-align: center;">Related Products</h2>
            <div class="product-grid">
                <% for (Product p : relatedProducts) { 
                    if (p.getId() == product.getId()) continue;
                %>
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

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-bottom" style="border-top: none;">
                <p>&copy; 2026 ABIMART Inc. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        function changeImage(element, src) {
            document.getElementById('mainImage').src = src;
            document.querySelectorAll('.thumbnail').forEach(el => el.classList.remove('active'));
            element.classList.add('active');
        }
    </script>
</body>
</html>
