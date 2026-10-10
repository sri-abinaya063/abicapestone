<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders - ABIMART</title>
    <link rel="stylesheet" href="../css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .profile-layout {
            display: grid;
            grid-template-columns: 250px 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }
        @media (max-width: 768px) {
            .profile-layout { grid-template-columns: 1fr; }
        }
        .sidebar-menu {
            background: var(--bg-main);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            overflow: hidden;
            height: fit-content;
        }
        .sidebar-menu a {
            display: block;
            padding: 1rem 1.5rem;
            color: var(--text-secondary);
            font-weight: 500;
            border-bottom: 1px solid var(--border-color);
            transition: all var(--transition-fast);
        }
        .sidebar-menu a:last-child { border-bottom: none; }
        .sidebar-menu a:hover { background: var(--bg-secondary); color: var(--text-primary); }
        .sidebar-menu a.active { background: var(--bg-tertiary); color: var(--accent); border-left: 3px solid var(--accent); }
        .sidebar-menu a i { width: 24px; }
        
        .empty-orders {
            background: var(--bg-main);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 4rem 2rem;
            text-align: center;
        }
        .empty-orders i {
            font-size: 3rem;
            color: var(--text-muted);
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body style="background: var(--bg-secondary);">
    <!-- Navigation -->
    <nav class="navbar">
        <a href="../index.jsp" class="nav-brand">
            <i class="fa-solid fa-cube" style="color: var(--accent);"></i>
            ABIMART
        </a>
        <div class="nav-links">
            <a href="products.jsp">Shop</a>
            <a href="cart.jsp" class="icon-btn">
                <i class="fa-solid fa-bag-shopping"></i>
            </a>
            <a href="../auth?action=logout" class="btn btn-outline" style="padding: 0.5rem 1rem;">Logout</a>
        </div>
    </nav>

    <!-- Content -->
    <div class="container" style="padding: 3rem 5%; min-height: 70vh;">
        <h1 style="font-size: 2rem; margin-bottom: 1rem;">My Account</h1>
        
        <div class="profile-layout">
            <div class="sidebar-menu">
                <a href="#" class="active"><i class="fa-solid fa-box-open"></i> Order History</a>
                <a href="#"><i class="fa-regular fa-heart"></i> Wishlist</a>
                <a href="#"><i class="fa-regular fa-address-book"></i> Saved Addresses</a>
                <a href="#"><i class="fa-solid fa-gear"></i> Settings</a>
            </div>
            
            <div>
                <!-- Since backend doesn't populate orders yet via JSP logic -->
                <div class="empty-orders">
                    <i class="fa-solid fa-receipt"></i>
                    <h3>No orders yet</h3>
                    <p class="text-secondary mt-1 mb-4">When you place an order, it will appear here.</p>
                    <a href="products.jsp" class="btn btn-primary">Start Shopping</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
