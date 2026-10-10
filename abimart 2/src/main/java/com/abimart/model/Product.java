package com.abimart.model;

import java.util.List;

public class Product {
    private String id;
    private String name;
    private String brand;
    private String category;
    private String description;
    private double price;
    private double discountPercentage;
    private double finalPrice;
    private double rating;
    private int reviewCount;
    private int stock;
    private String thumbnail;
    private List<String> images;
    
    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getTitle() { return name; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    // getPrice returns the final selling price for JSP compatibility
    public double getPrice() { return finalPrice > 0 ? finalPrice : price; }
    public void setPrice(double price) { this.price = price; }
    
    public double getDiscountPercentage() { return discountPercentage; }
    public void setDiscountPercentage(double discountPercentage) { this.discountPercentage = discountPercentage; }
    
    public void setFinalPrice(double finalPrice) { this.finalPrice = finalPrice; }
    
    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }
    
    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
    
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
    
    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }
    
    public List<String> getImages() { return images; }
    public void setImages(List<String> images) { this.images = images; }
    
    // Original MRP
    public double getOriginalPrice() {
        return price;
    }
}
