import json
import uuid
import random

categories = {
    "Electronics": ["Smartphone", "Laptop", "Tablet", "Monitor", "Television", "Headphones", "Earbuds", "Bluetooth Speaker", "Smartwatch", "Camera", "Gaming Console", "Keyboard", "Mouse", "Printer", "Power Bank", "Charger", "USB Drive", "SSD", "Hard Drive", "Router"],
    "Fashion": ["Men's T-Shirt", "Men's Shirt", "Jeans", "Trousers", "Hoodie", "Jacket", "Sneakers", "Formal Shoes", "Sandals", "Women's Dress", "Top", "Saree", "Kurti", "Women's Jeans", "Handbag", "Backpack", "Wallet", "Belt", "Sunglasses", "Watch"],
    "Home & Living": ["Sofa", "Bed", "Mattress", "Table", "Chair", "Wardrobe", "Bookshelf", "Study Table", "Lamp", "Curtain", "Carpet", "Cushion", "Bedsheet", "Pillow", "Home Decor", "Wall Decor", "Clock", "Vase", "Rug", "Mirror"],
    "Kitchen & Appliances": ["Refrigerator", "Washing Machine", "Air Conditioner", "Microwave Oven", "Mixer Grinder", "Induction Cooktop", "Electric Kettle", "Air Fryer", "Rice Cooker", "Toaster", "Coffee Maker", "Juicer", "Water Purifier", "Vacuum Cleaner", "Dishwasher", "Oven", "Blender", "Food Processor", "Chimney", "Water Heater"],
    "Beauty & Personal Care": ["Face Wash", "Moisturizer", "Sunscreen", "Serum", "Shampoo", "Conditioner", "Hair Oil", "Hair Dryer", "Trimmer", "Shaver", "Lipstick", "Foundation", "Perfume", "Deodorant", "Grooming Kit", "Skincare Kit", "Body Lotion", "Soap", "Hair Gel", "Face Mask"],
    "Sports & Fitness": ["Running Shoes", "Sports Shoes", "Cricket Bat", "Cricket Ball", "Football", "Basketball", "Badminton Racket", "Shuttlecock", "Tennis Racket", "Yoga Mat", "Dumbbell", "Resistance Band", "Gym Gloves", "Sports Bag", "Water Bottle", "Treadmill", "Cycling Bike", "Protein Powder", "Jump Rope", "Fitness Tracker"],
    "Grocery & Food": ["Rice", "Wheat", "Atta", "Pulses", "Dal", "Cooking Oil", "Spices", "Masala", "Snacks", "Biscuits", "Chocolates", "Tea", "Coffee", "Dry Fruits", "Breakfast Food", "Beverage", "Noodles", "Pasta", "Honey", "Sugar"],
    "Books & Stationery": ["Textbook", "Novel", "Business Book", "Academic Book", "Notebook", "Diary", "Pen", "Pencil", "Marker", "File", "Office Supplies", "Art Supplies", "School Supplies", "Eraser", "Highlighter", "Stapler", "Sticky Notes", "Calculator", "Geometry Box", "Sketch Pen"],
    "Toys & Baby": ["Baby Clothes", "Baby Care", "Baby Bottle", "Diaper", "Toy", "Educational Toy", "Remote Control Car", "Doll", "Board Game", "Building Blocks", "Kids Book", "Action Figure", "Puzzle", "Soft Toy", "Baby Stroller", "Baby Cot", "Baby Wipes", "Baby Food", "Rattle", "Playmat"],
    "Automotive": ["Car Accessory", "Bike Accessory", "Car Charger", "Phone Holder", "Seat Cover", "Floor Mat", "Cleaning Product", "Bike Helmet", "Car Care Product", "Emergency Accessory", "Engine Oil", "Tire", "Car Perfume", "Dash Cam", "Wiper Blade", "Car Cover", "Bike Cover", "Tool Kit", "Jump Starter", "Air Compressor"],
    "Travel & Luggage": ["Suitcase", "Trolley Bag", "Travel Backpack", "Duffel Bag", "Laptop Bag", "Travel Organizer", "Travel Accessory", "Neck Pillow", "Travel Bottle", "Passport Cover", "Luggage Tag", "Eye Mask", "Travel Lock", "Toiletry Bag", "Travel Adapter", "Packing Cube", "Travel Wallet", "Umbrella", "Camping Tent", "Sleeping Bag"],
    "Pet Supplies": ["Dog Food", "Cat Food", "Pet Toy", "Pet Bed", "Pet Bowl", "Collar", "Leash", "Pet Grooming Product", "Bird Food", "Fish Food", "Aquarium", "Pet Carrier", "Pet Shampoo", "Litter Box", "Cat Litter", "Scratching Post", "Dog Chew", "Pet Treat", "Bird Cage", "Pet Brush"]
}

brands = {
    "Electronics": ["Apple", "Samsung", "Sony", "Dell", "HP", "Lenovo", "Asus", "Acer", "LG", "Panasonic"],
    "Fashion": ["Nike", "Adidas", "Puma", "Reebok", "Levi's", "Zara", "H&M", "Gucci", "Prada", "Rolex"],
    "Home & Living": ["IKEA", "HomeTown", "Urban Ladder", "Pepperfry", "Bombay Dyeing", "Spaces", "D'Decor", "Swayam", "Portico", "Hometown"],
    "Kitchen & Appliances": ["LG", "Samsung", "Whirlpool", "Bosch", "IFB", "Philips", "Bajaj", "Prestige", "Pigeon", "Butterfly"],
    "Beauty & Personal Care": ["L'Oreal", "Maybelline", "Lakme", "MAC", "Nivea", "Dove", "Garnier", "Olay", "Pond's", "Biotique"],
    "Sports & Fitness": ["Nike", "Adidas", "Puma", "Reebok", "Under Armour", "Decathlon", "Yonex", "Nivia", "Cosco", "Spalding"],
    "Grocery & Food": ["Nestle", "Amul", "Britannia", "Parle", "ITC", "Tata", "Haldiram's", "Patanjali", "Dabur", "MTR"],
    "Books & Stationery": ["Classmate", "Cello", "Reynolds", "Parker", "Faber-Castell", "Camlin", "Navneet", "Luxor", "Kangaro", "Nataraj"],
    "Toys & Baby": ["Fisher-Price", "Lego", "Hot Wheels", "Barbie", "Nerf", "Hasbro", "Mattel", "Funskool", "Mee Mee", "Chicco"],
    "Automotive": ["Bosch", "Castrol", "Motul", "Michelin", "MRF", "CEAT", "Pioneer", "JBL", "Sony", "Philips"],
    "Travel & Luggage": ["American Tourister", "VIP", "Skybags", "Safari", "Wildcraft", "Tommy Hilfiger", "Samsonite", "Aristocrat", "Puma", "Nike"],
    "Pet Supplies": ["Pedigree", "Whiskas", "Royal Canin", "Drools", "Himalaya", "Choostix", "Meat Up", "Purepet", "Goodies", "Petcare"]
}

fallback_images = {
    "Electronics": "https://images.unsplash.com/photo-1498049794561-7780e7231661?w=500&q=80",
    "Fashion": "https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&q=80",
    "Home & Living": "https://images.unsplash.com/photo-1449247709967-d4461a6a6103?w=500&q=80",
    "Kitchen & Appliances": "https://images.unsplash.com/photo-1556910103-1c02745a872f?w=500&q=80",
    "Beauty & Personal Care": "https://images.unsplash.com/photo-1596462502278-27bf85033e5a?w=500&q=80",
    "Sports & Fitness": "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=500&q=80",
    "Grocery & Food": "https://images.unsplash.com/photo-1542838132-92c53300491e?w=500&q=80",
    "Books & Stationery": "https://images.unsplash.com/photo-1544816155-12df9643f363?w=500&q=80",
    "Toys & Baby": "https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=500&q=80",
    "Automotive": "https://images.unsplash.com/photo-1511919884226-fd3cad34687c?w=500&q=80",
    "Travel & Luggage": "https://images.unsplash.com/photo-1553531384-cc64ac80f931?w=500&q=80",
    "Pet Supplies": "https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=500&q=80"
}

with open("seed.sql", "w", encoding="utf-8") as f:
    f.write("DELETE FROM product_images;\n")
    f.write("DELETE FROM products;\n")
    f.write("DELETE FROM categories;\n")
    
    cat_id = 1
    for cat_name in categories.keys():
        slug = cat_name.lower().replace(" & ", "-").replace(" ", "-")
        f.write(f"INSERT INTO categories (id, name, slug) VALUES ({cat_id}, '{cat_name}', '{slug}');\n")
        
        for item in categories[cat_name]:
            brand = random.choice(brands[cat_name])
            product_name = f"{brand} {item}"
            product_slug = product_name.lower().replace(" ", "-").replace("'", "")
            product_id = str(uuid.uuid4())
            price = round(random.uniform(10, 1000), 2)
            discount = round(random.uniform(0, 30), 2)
            stock = random.randint(10, 100)
            rating = round(random.uniform(3, 5), 2)
            reviews = random.randint(10, 500)
            
            f.write(f"INSERT INTO products (id, seller_id, category_id, name, slug, brand, price, discount_percent, stock, is_active, avg_rating, total_reviews) VALUES ('{product_id}', 'SYSTEM', {cat_id}, '{product_name}', '{product_slug}', '{brand}', {price}, {discount}, {stock}, TRUE, {rating}, {reviews});\n")
            
            img_url = fallback_images[cat_name]
            f.write(f"INSERT INTO product_images (product_id, image_url, is_primary) VALUES ('{product_id}', '{img_url}', TRUE);\n")
            
        cat_id += 1
