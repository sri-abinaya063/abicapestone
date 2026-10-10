package com.abimart.dao;

import com.abimart.config.DatabaseConfig;
import com.abimart.model.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    
    // Kept for JSP compatibility but does nothing now
    public static void init(java.io.InputStream ignored) {}
    
    private Product mapRowToProduct(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getString("id"));
        p.setName(rs.getString("name"));
        p.setBrand(rs.getString("brand"));
        
        // Final selling price
        p.setFinalPrice(rs.getDouble("final_price"));
        // MRP
        p.setPrice(rs.getDouble("price"));
        p.setDiscountPercentage(rs.getDouble("discount_percent"));
        
        p.setStock(rs.getInt("stock"));
        p.setRating(rs.getDouble("avg_rating"));
        p.setReviewCount(rs.getInt("total_reviews"));
        p.setDescription(rs.getString("description"));
        
        // We will query primary image as thumbnail
        p.setThumbnail(getThumbnailForProduct(rs.getString("id")));
        p.setCategory(getCategoryName(rs.getInt("category_id")));
        
        return p;
    }
    
    private String getThumbnailForProduct(String productId) {
        String sql = "SELECT image_url FROM product_images WHERE product_id = ? ORDER BY is_primary DESC, sort_order ASC LIMIT 1";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("image_url");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "https://via.placeholder.com/300?text=No+Image";
    }
    
    public List<String> getImagesForProduct(String productId) {
        List<String> images = new ArrayList<>();
        String sql = "SELECT image_url FROM product_images WHERE product_id = ? ORDER BY is_primary DESC, sort_order ASC";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, productId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                images.add(rs.getString("image_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }
    
    private String getCategoryName(int categoryId) {
        String sql = "SELECT name FROM categories WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Uncategorized";
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE is_active = TRUE";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                products.add(mapRowToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(String id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Product p = mapRowToProduct(rs);
                p.setImages(getImagesForProduct(id));
                return p;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getProductsByCategory(String category) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.* FROM products p JOIN categories c ON p.category_id = c.id WHERE c.name = ? OR c.slug = ? AND p.is_active = TRUE";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, category);
            stmt.setString(2, category.toLowerCase().replace(" ", "-"));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapRowToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> searchProducts(String query) {
        if (query == null || query.trim().isEmpty()) return getAllProducts();
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.* FROM products p JOIN categories c ON p.category_id = c.id " + 
                     "WHERE (LOWER(p.name) LIKE ? OR LOWER(p.brand) LIKE ? OR LOWER(c.name) LIKE ?) AND p.is_active = TRUE";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String q = "%" + query.toLowerCase() + "%";
            stmt.setString(1, q);
            stmt.setString(2, q);
            stmt.setString(3, q);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapRowToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getFeaturedProducts(int limit) {
        return fetchList("SELECT * FROM products WHERE is_active = TRUE ORDER BY avg_rating DESC LIMIT ?", limit);
    }
    
    public List<Product> getTrendingProducts(int limit) {
        return fetchList("SELECT * FROM products WHERE is_active = TRUE ORDER BY total_reviews DESC LIMIT ?", limit);
    }
    
    public List<Product> getBestSellers(int limit) {
        return fetchList("SELECT * FROM products WHERE is_active = TRUE ORDER BY total_sold DESC, stock ASC LIMIT ?", limit);
    }
    
    public List<Product> getNewArrivals(int limit) {
        return fetchList("SELECT * FROM products WHERE is_active = TRUE ORDER BY created_at DESC LIMIT ?", limit);
    }
    
    public List<Product> getTopDeals(int limit) {
        return fetchList("SELECT * FROM products WHERE is_active = TRUE AND discount_percent > 15 ORDER BY discount_percent DESC LIMIT ?", limit);
    }
    
    private List<Product> fetchList(String sql, int limit) {
        List<Product> products = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapRowToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
