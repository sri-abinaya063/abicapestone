import urllib.request
import json
import pymysql

# Connect to database
try:
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='',
        database='abimart',
        cursorclass=pymysql.cursors.DictCursor
    )
except Exception as e:
    print(f"Connection failed: {e}")
    exit(1)

with connection:
    with connection.cursor() as cursor:
        # Create table
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS products (
                id INT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                brand VARCHAR(100),
                category VARCHAR(100),
                description TEXT,
                price DECIMAL(10,2),
                discount_percentage DECIMAL(5,2),
                rating DECIMAL(3,2),
                stock INT,
                image_url VARCHAR(500),
                thumbnail_url VARCHAR(500)
            )
        ''')
        # Clear existing
        cursor.execute('TRUNCATE TABLE products')
        
        # Fetch dummyjson products (limit 200)
        url = "https://dummyjson.com/products?limit=200"
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req) as response:
            data = json.loads(response.read().decode())
            products = data.get('products', [])
            
            print(f"Fetched {len(products)} products.")
            
            for p in products:
                # Map fields
                name = p.get('title', '')
                brand = p.get('brand', '')
                category = p.get('category', '')
                desc = p.get('description', '')
                price = p.get('price', 0)
                discount = p.get('discountPercentage', 0)
                rating = p.get('rating', 0)
                stock = p.get('stock', 0)
                images = p.get('images', [])
                img = images[0] if images else ''
                thumb = p.get('thumbnail', '')
                
                cursor.execute('''
                    INSERT INTO products 
                    (name, brand, category, description, price, discount_percentage, rating, stock, image_url, thumbnail_url)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ''', (name, brand, category, desc, price, discount, rating, stock, img, thumb))
                
        connection.commit()
        print("Successfully seeded products table.")
