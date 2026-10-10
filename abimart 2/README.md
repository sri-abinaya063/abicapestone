# ABIMART E-Commerce Website

## Project Description
ABIMART is a full-featured, Java-based E-commerce website supporting Buyer, Seller, and Admin roles. It includes product management, shopping cart, checkout processing, order history, user ratings, and an interactive AI Chatbot assistant.

## Features
- **User Authentication:** Registration, Login, Logout, Session Management with Password Hashing.
- **Buyer Products + Search:** Browse, search, filter, and sort products with real database queries.
- **Cart + Checkout:** Add to cart, view total, select delivery address, and place an order.
- **Order History:** View placed orders and track order status.
- **Reviews + Ratings:** Eligible buyers can rate and review purchased products.
- **Seller Product Management:** Dedicated dashboard to add, edit, and delete products, plus inventory management.
- **Admin Panel:** Complete dashboard to manage users, sellers, products, categories, orders, and reviews.
- **AI Chatbot:** Built-in virtual assistant to help with product search, category info, and order status.
- **Security:** SQL Injection prevention, Prepared Statements, and Role-Based Authorization.

## Technology Stack
- **Backend:** Java, Servlets, JSP
- **Build Tool:** Maven
- **Database:** MySQL & JDBC
- **Web Server:** Apache Tomcat
- **Frontend:** HTML, CSS, JavaScript (Vanilla)

## System Requirements
- Java Development Kit (JDK) 11 or higher
- Apache Maven 3.6+
- Apache Tomcat 9.0+
- MySQL Server 8.0+

## Project Structure
```text
abimart/
├── pom.xml
├── database/
│   └── schema.sql
├── documentation/
│   └── docs/ (Contains Diagrams)
├── src/
│   └── main/
│       ├── java/com/abimart/
│       │   ├── config/
│       │   ├── controller/
│       │   ├── dao/
│       │   ├── filter/
│       │   ├── model/
│       │   └── service/
│       └── webapp/
│           ├── admin/
│           ├── buyer/
│           ├── seller/
│           ├── css/
│           ├── js/
│           ├── images/
│           ├── WEB-INF/
│           └── index.jsp
```

## Setup Instructions

### Java Setup
Ensure `JAVA_HOME` is set to your JDK installation path and accessible via terminal.

### Maven Setup
Ensure Maven is installed and `mvn` is added to your system `PATH`.

### Tomcat Setup
Download Apache Tomcat. Configure it within your IDE (Eclipse/IntelliJ) or deploy the final WAR file to `tomcat/webapps/`.

### MySQL Setup
1. Open MySQL Command Line or Workbench.
2. Create the database using the schema.

### Database Import
Run the provided SQL script:
```sql
mysql -u root -p < database/schema.sql
```

### Configuration
Update your database credentials in the configuration file:
`src/main/java/com/abimart/config/DatabaseConfig.java`
Update `USER` and `PASSWORD` to match your local MySQL configuration.

### AI Chatbot Setup
The AI chatbot is available at `/chat.jsp`. It uses the internal `ChatbotServlet` for mock responses. If connecting an external API (like Gemini/OpenAI), add your API keys as Environment Variables in Tomcat.

## How to Run
1. Open terminal in the project root directory.
2. Run `mvn clean package`.
3. Copy the generated `target/abimart-ecommerce-1.0-SNAPSHOT.war` to Tomcat's `webapps` folder.
4. Start Tomcat and navigate to `http://localhost:8080/abimart-ecommerce-1.0-SNAPSHOT/`.

## User Roles

### Admin Usage
- Login with an Admin account.
- Manage and activate/deactivate standard Users and Sellers.
- Moderate products and reviews.
- Update global order statuses.

### Seller Usage
- Login via the Seller Dashboard.
- Manage inventory (Add/Edit/Delete products).
- Monitor sales and ratings.

### Buyer Usage
- Create an account or login.
- Search and filter products.
- Add products to the cart and proceed to checkout.
- Leave reviews for purchased products.

## Testing
- Test database connection by attempting a test Registration.
- Verify Servlet mappings and Role-based filtering.
- Simulate Cart and Checkout flow completely.

## Deployment
For production deployment, ensure the `DatabaseConfig.java` points to a production database and deploy the WAR file on a secure cloud-hosted Tomcat server.

## Diagrams (documentation/docs)
- **ER Diagram:** Shows relations between Users, Roles, Categories, Products, Cart, Orders, Payments, and Reviews.
- **Use Case Diagram:** Defines interactions for Buyer, Seller, and Admin.
- **Sequence Diagrams:** Tracks the flow for Registration, Login, Checkout, etc.

## GitHub Setup
This project has been cleaned of temporary files and build artifacts and is ready to be committed and pushed to GitHub.
```bash
git init
git add .
git commit -m "Initial commit of ABIMART Java MVC"
git push origin main
```
