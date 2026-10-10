-- ABI MART Database Schema
-- MySQL 8+
-- Run: mysql -u root -p < database/schema.sql

CREATE DATABASE IF NOT EXISTS abimart CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE abimart;

-- ============================================================
-- ROLES
-- ============================================================
CREATE TABLE IF NOT EXISTS roles (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO roles (name, description) VALUES
  ('buyer', 'Regular customer who can buy products'),
  ('seller', 'Vendor who can list and sell products'),
  ('admin', 'Platform administrator with full access');

-- ============================================================
-- USERS
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
  id VARCHAR(36) PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE,
  mobile VARCHAR(20) UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role_id INT NOT NULL DEFAULT 1,
  profile_image VARCHAR(500),
  is_active BOOLEAN DEFAULT TRUE,
  is_email_verified BOOLEAN DEFAULT FALSE,
  is_mobile_verified BOOLEAN DEFAULT FALSE,
  remember_token VARCHAR(255),
  last_login TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE RESTRICT,
  INDEX idx_email (email),
  INDEX idx_mobile (mobile),
  INDEX idx_role (role_id)
);

-- ============================================================
-- SELLERS
-- ============================================================
CREATE TABLE IF NOT EXISTS sellers (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL UNIQUE,
  shop_name VARCHAR(255) NOT NULL,
  shop_description TEXT,
  shop_logo VARCHAR(500),
  gst_number VARCHAR(50),
  pan_number VARCHAR(50),
  bank_account VARCHAR(100),
  ifsc_code VARCHAR(20),
  is_approved BOOLEAN DEFAULT FALSE,
  is_active BOOLEAN DEFAULT TRUE,
  total_sales DECIMAL(15,2) DEFAULT 0.00,
  rating DECIMAL(3,2) DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user_id (user_id)
);

-- ============================================================
-- CATEGORIES
-- ============================================================
CREATE TABLE IF NOT EXISTS categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  parent_id INT NULL,
  description TEXT,
  image VARCHAR(500),
  icon VARCHAR(100),
  sort_order INT DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (parent_id) REFERENCES categories(id) ON DELETE SET NULL,
  INDEX idx_parent (parent_id),
  INDEX idx_slug (slug)
);

-- ============================================================
-- PRODUCTS
-- ============================================================
CREATE TABLE IF NOT EXISTS products (
  id VARCHAR(36) PRIMARY KEY,
  seller_id VARCHAR(36) NOT NULL,
  category_id INT NOT NULL,
  subcategory_id INT NULL,
  name VARCHAR(500) NOT NULL,
  slug VARCHAR(500) NOT NULL,
  brand VARCHAR(255),
  sku VARCHAR(100) UNIQUE,
  description LONGTEXT,
  price DECIMAL(10,2) NOT NULL,
  discount_percent DECIMAL(5,2) DEFAULT 0.00,
  final_price DECIMAL(10,2) GENERATED ALWAYS AS (ROUND(price * (1 - discount_percent/100), 2)),
  stock INT NOT NULL DEFAULT 0,
  min_order INT DEFAULT 1,
  max_order INT DEFAULT 10,
  is_active BOOLEAN DEFAULT TRUE,
  is_approved BOOLEAN DEFAULT FALSE,
  is_featured BOOLEAN DEFAULT FALSE,
  is_trending BOOLEAN DEFAULT FALSE,
  is_bestseller BOOLEAN DEFAULT FALSE,
  is_new_arrival BOOLEAN DEFAULT FALSE,
  total_sold INT DEFAULT 0,
  avg_rating DECIMAL(3,2) DEFAULT 0.00,
  total_reviews INT DEFAULT 0,
  views INT DEFAULT 0,
  specifications JSON,
  tags VARCHAR(1000),
  meta_title VARCHAR(500),
  meta_description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (seller_id) REFERENCES sellers(id) ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
  FOREIGN KEY (subcategory_id) REFERENCES categories(id) ON DELETE SET NULL,
  INDEX idx_seller (seller_id),
  INDEX idx_category (category_id),
  INDEX idx_prod_slug (slug),
  INDEX idx_prod_price (final_price),
  INDEX idx_prod_rating (avg_rating),
  INDEX idx_prod_active_approved (is_active, is_approved)
);

-- ============================================================
-- PRODUCT IMAGES
-- ============================================================
CREATE TABLE IF NOT EXISTS product_images (
  id INT PRIMARY KEY AUTO_INCREMENT,
  product_id VARCHAR(36) NOT NULL,
  image_url VARCHAR(1000) NOT NULL,
  alt_text VARCHAR(255),
  sort_order INT DEFAULT 0,
  is_primary BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  INDEX idx_product (product_id)
);

-- ============================================================
-- ADDRESSES
-- ============================================================
CREATE TABLE IF NOT EXISTS addresses (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  mobile VARCHAR(20) NOT NULL,
  door_number VARCHAR(100),
  street VARCHAR(500) NOT NULL,
  area VARCHAR(255),
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  pincode VARCHAR(20) NOT NULL,
  address_type ENUM('home','work','other') DEFAULT 'home',
  is_default BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_user (user_id)
);

-- ============================================================
-- CART
-- ============================================================
CREATE TABLE IF NOT EXISTS cart (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS cart_items (
  id VARCHAR(36) PRIMARY KEY,
  cart_id VARCHAR(36) NOT NULL,
  product_id VARCHAR(36) NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  price_at_add DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (cart_id) REFERENCES cart(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  UNIQUE KEY uk_cart_product (cart_id, product_id),
  INDEX idx_cart (cart_id)
);

-- ============================================================
-- WISHLIST
-- ============================================================
CREATE TABLE IF NOT EXISTS wishlist (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS wishlist_items (
  id VARCHAR(36) PRIMARY KEY,
  wishlist_id VARCHAR(36) NOT NULL,
  product_id VARCHAR(36) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (wishlist_id) REFERENCES wishlist(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  UNIQUE KEY uk_wishlist_product (wishlist_id, product_id),
  INDEX idx_wishlist (wishlist_id)
);

-- ============================================================
-- ORDERS
-- ============================================================
CREATE TABLE IF NOT EXISTS orders (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) NOT NULL,
  address_id VARCHAR(36) NOT NULL,
  status ENUM('placed','confirmed','packed','shipped','out_for_delivery','delivered','cancelled','refunded') DEFAULT 'placed',
  payment_method ENUM('cod','upi','card','netbanking') NOT NULL,
  payment_status ENUM('pending','paid','failed','refunded') DEFAULT 'pending',
  subtotal DECIMAL(10,2) NOT NULL,
  discount_amount DECIMAL(10,2) DEFAULT 0.00,
  delivery_charge DECIMAL(10,2) DEFAULT 0.00,
  total_amount DECIMAL(10,2) NOT NULL,
  notes TEXT,
  tracking_number VARCHAR(100),
  estimated_delivery DATE,
  delivered_at TIMESTAMP NULL,
  cancelled_at TIMESTAMP NULL,
  cancel_reason TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT,
  FOREIGN KEY (address_id) REFERENCES addresses(id) ON DELETE RESTRICT,
  INDEX idx_order_user (user_id),
  INDEX idx_order_status (status),
  INDEX idx_order_created (created_at)
);

CREATE TABLE IF NOT EXISTS order_items (
  id VARCHAR(36) PRIMARY KEY,
  order_id VARCHAR(36) NOT NULL,
  product_id VARCHAR(36) NOT NULL,
  seller_id VARCHAR(36) NOT NULL,
  product_name VARCHAR(500) NOT NULL,
  product_image VARCHAR(1000),
  brand VARCHAR(255),
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  discount_percent DECIMAL(5,2) DEFAULT 0.00,
  final_price DECIMAL(10,2) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  status ENUM('placed','confirmed','packed','shipped','out_for_delivery','delivered','cancelled','refunded') DEFAULT 'placed',
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT,
  FOREIGN KEY (seller_id) REFERENCES sellers(id) ON DELETE RESTRICT,
  INDEX idx_orderitem_order (order_id),
  INDEX idx_orderitem_seller (seller_id)
);

CREATE TABLE IF NOT EXISTS order_status_history (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id VARCHAR(36) NOT NULL,
  status ENUM('placed','confirmed','packed','shipped','out_for_delivery','delivered','cancelled','refunded') NOT NULL,
  message TEXT,
  updated_by VARCHAR(36),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  INDEX idx_history_order (order_id)
);

-- ============================================================
-- PAYMENTS
-- ============================================================
CREATE TABLE IF NOT EXISTS payments (
  id VARCHAR(36) PRIMARY KEY,
  order_id VARCHAR(36) NOT NULL UNIQUE,
  method ENUM('cod','upi','card','netbanking') NOT NULL,
  status ENUM('pending','completed','failed','refunded') DEFAULT 'pending',
  transaction_id VARCHAR(255),
  gateway_response JSON,
  amount DECIMAL(10,2) NOT NULL,
  paid_at TIMESTAMP NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- ============================================================
-- REVIEWS
-- ============================================================
CREATE TABLE IF NOT EXISTS reviews (
  id VARCHAR(36) PRIMARY KEY,
  product_id VARCHAR(36) NOT NULL,
  user_id VARCHAR(36) NOT NULL,
  order_item_id VARCHAR(36) NULL,
  rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  title VARCHAR(255),
  comment TEXT,
  images JSON,
  is_verified_purchase BOOLEAN DEFAULT FALSE,
  is_approved BOOLEAN DEFAULT TRUE,
  helpful_count INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE KEY uk_user_product (user_id, product_id),
  INDEX idx_product (product_id),
  INDEX idx_user (user_id)
);

-- ============================================================
-- SEED DATA
-- ============================================================

-- Insert categories
INSERT IGNORE INTO categories (name, slug, parent_id, icon, sort_order) VALUES
  ('Electronics', 'electronics', NULL, '⚡', 1),
  ('Mobiles', 'mobiles', 1, '📱', 2),
  ('Laptops', 'laptops', 1, '💻', 3),
  ('Computers', 'computers', 1, '🖥️', 4),
  ('Tablets', 'tablets', 1, '📟', 5),
  ('Audio & Headphones', 'audio-headphones', 1, '🎧', 6),
  ('Cameras', 'cameras', 1, '📷', 7),
  ('Fashion', 'fashion', NULL, '👗', 8),
  ('Men\'s Fashion', 'mens-fashion', 8, '👔', 9),
  ('Women\'s Fashion', 'womens-fashion', 8, '👗', 10),
  ('Footwear', 'footwear', 8, '👟', 11),
  ('Kids Fashion', 'kids-fashion', 8, '👶', 12),
  ('Home & Kitchen', 'home-kitchen', NULL, '🏠', 13),
  ('Furniture', 'furniture', 13, '🛋️', 14),
  ('Kitchen Appliances', 'kitchen-appliances', 13, '🍳', 15),
  ('Bedding & Bath', 'bedding-bath', 13, '🛏️', 16),
  ('Beauty', 'beauty', NULL, '💄', 17),
  ('Skincare', 'skincare', 17, '✨', 18),
  ('Haircare', 'haircare', 17, '💆', 19),
  ('Sports', 'sports', NULL, '⚽', 20),
  ('Fitness Equipment', 'fitness-equipment', 20, '🏋️', 21),
  ('Sports Wear', 'sports-wear', 20, '🏃', 22),
  ('Books', 'books', NULL, '📚', 23),
  ('Fiction', 'fiction', 23, '📖', 24),
  ('Non-Fiction', 'non-fiction', 23, '📕', 25),
  ('Accessories', 'accessories', NULL, '⌚', 26),
  ('Watches', 'watches', 26, '⌚', 27),
  ('Bags', 'bags', 26, '👜', 28),
  ('Sunglasses', 'sunglasses', 26, '🕶️', 29);
