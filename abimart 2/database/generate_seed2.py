import urllib.request, json, uuid, random, copy

with open('../src/main/webapp/products.json', 'r', encoding='utf-8') as f:
    data = json.load(f)

user_cats = ['Electronics', 'Fashion', 'Home & Living', 'Kitchen & Appliances', 'Beauty & Personal Care', 'Sports & Fitness', 'Grocery & Food', 'Books & Stationery', 'Toys & Baby', 'Automotive', 'Travel & Luggage', 'Pet Supplies']

dummy_mapping = {
    'smartphones': 'Electronics',
    'laptops': 'Electronics',
    'mens-watches': 'Electronics',
    'womens-watches': 'Electronics',
    'mens-shirts': 'Fashion',
    'mens-shoes': 'Fashion',
    'womens-dresses': 'Fashion',
    'womens-shoes': 'Fashion',
    'womens-bags': 'Fashion',
    'womens-jewellery': 'Fashion',
    'sunglasses': 'Fashion',
    'tops': 'Fashion',
    'furniture': 'Home & Living',
    'home-decoration': 'Home & Living',
    'lighting': 'Home & Living',
    'kitchen-accessories': 'Kitchen & Appliances',
    'beauty': 'Beauty & Personal Care',
    'fragrances': 'Beauty & Personal Care',
    'skin-care': 'Beauty & Personal Care',
    'sports-accessories': 'Sports & Fitness',
    'groceries': 'Grocery & Food',
    'motorcycle': 'Automotive',
    'vehicle': 'Automotive'
}

products_by_cat = {c: [] for c in user_cats}

for p in data['products']:
    cat = p.get('category', '')
    target = dummy_mapping.get(cat, 'Home & Living')
    products_by_cat[target].append(p)

with open('seed.sql', 'w', encoding='utf-8') as f:
    f.write('DELETE FROM product_images;\n')
    f.write('DELETE FROM products;\n')
    f.write('DELETE FROM categories;\n')
    
    # SYSTEM seller and user
    f.write("INSERT INTO users (id, full_name, email, password_hash, role_id) VALUES ('SYSTEM_USER', 'System User', 'admin@abimart.com', 'dummyhash', 3);\n")
    f.write("INSERT INTO sellers (id, user_id, shop_name) VALUES ('SYSTEM', 'SYSTEM_USER', 'Abimart Official');\n")
    
    cat_id = 1
    for c in user_cats:
        slug = c.lower().replace(' & ', '-').replace(' ', '-')
        f.write(f"INSERT INTO categories (id, name, slug, is_active) VALUES ({cat_id}, '{c}', '{slug}', TRUE);\n")
        
        prods = products_by_cat[c]
        if len(prods) < 20:
            while len(prods) < 20:
                if len(prods) > 0:
                    base = random.choice(prods)
                    new_p = copy.deepcopy(base)
                    new_p['title'] = new_p['title'] + ' Pro'
                    prods.append(new_p)
                else:
                    prods.append({'title': c + ' Item', 'brand': 'Generic', 'price': 100, 'discountPercentage': 10, 'stock': 50, 'rating': 4.5, 'reviews': [], 'thumbnail': 'https://via.placeholder.com/300?text='+c.replace(' ','+'), 'description': 'Description for ' + c})
        
        for p in prods:
            pid = str(uuid.uuid4())
            name = str(p['title']).replace("'", "''")
            brand = str(p.get('brand', 'Generic')).replace("'", "''")
            desc = str(p.get('description', '')).replace("'", "''")
            price = p.get('price', 100)
            discount = p.get('discountPercentage', 0)
            stock = p.get('stock', 50)
            rating = p.get('rating', 4.5)
            revs = len(p.get('reviews', [])) if 'reviews' in p else random.randint(10, 100)
            slug_p = name.lower().replace(' ', '-').replace("''", "")[:50]
            
            f.write(f"INSERT INTO products (id, seller_id, category_id, name, slug, brand, description, price, discount_percent, stock, is_active, avg_rating, total_reviews) VALUES ('{pid}', 'SYSTEM', {cat_id}, '{name}', '{slug_p}-{str(uuid.uuid4())[:8]}', '{brand}', '{desc}', {price}, {discount}, {stock}, TRUE, {rating}, {revs});\n")
            
            thumb = p.get('thumbnail', 'https://via.placeholder.com/300')
            f.write(f"INSERT INTO product_images (product_id, image_url, is_primary) VALUES ('{pid}', '{thumb}', TRUE);\n")
            
        cat_id += 1
