<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - ABIMART</title>
    <link rel="stylesheet" href="../css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .cart-layout {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }
        @media (min-width: 1024px) {
            .cart-layout { grid-template-columns: 2fr 1fr; }
        }
        .cart-items {
            background: var(--bg-main);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-xl);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
        }
        .cart-summary {
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-xl);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            position: sticky;
            top: 100px;
            height: fit-content;
        }
        .empty-cart-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }
        .empty-cart-state i {
            font-size: 4rem;
            color: var(--border-color);
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
            <a href="products.jsp">Continue Shopping</a>
            <a href="cart.jsp" class="icon-btn" style="color: var(--text-primary);">
                <i class="fa-solid fa-bag-shopping"></i>
                <span class="badge">0</span>
            </a>
            <a href="../auth?action=logout" class="btn btn-outline" style="padding: 0.5rem 1rem;">Logout</a>
        </div>
    </nav>

    <!-- Cart Content -->
    <div class="container" style="padding: 3rem 5%; min-height: 70vh;">
        <h1 style="font-size: 2rem; margin-bottom: 1rem;">Shopping Bag</h1>
        
        <div class="cart-layout">
            <div class="cart-items">
                <!-- Empty State (since the backend doesn't populate it yet via session items) -->
                <div class="empty-cart-state">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <h3>Your bag is empty</h3>
                    <p class="mb-4 mt-2">Looks like you haven't added anything to your cart yet.</p>
                    <a href="products.jsp" class="btn btn-primary">Start Shopping</a>
                </div>
            </div>
            
            <div class="cart-summary">
                <h3 style="margin-bottom: 1.5rem; font-size: 1.25rem;">Order Summary</h3>
                <div style="display: flex; justify-content: space-between; margin-bottom: 1rem; color: var(--text-secondary);">
                    <span>Subtotal</span>
                    <span>$0.00</span>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 1rem; color: var(--text-secondary);">
                    <span>Estimated Shipping</span>
                    <span>Free</span>
                </div>
                <hr style="border: 0; border-top: 1px solid var(--border-color); margin: 1.5rem 0;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 2rem; font-size: 1.25rem; font-weight: 700;">
                    <span>Total</span>
                    <span>$0.00</span>
                </div>
                
                <form action="checkout.jsp" method="post">
                    <button type="submit" class="btn btn-primary btn-block" style="padding: 1rem; font-size: 1.1rem;">
                        Proceed to Checkout <i class="fa-solid fa-arrow-right" style="margin-left: 0.5rem;"></i>
                    </button>
                </form>
                
                <div class="text-center mt-4 text-sm text-muted">
                    <i class="fa-solid fa-lock"></i> Secure Checkout
                </div>
            </div>
        </div>
    </div>
</body>
</html>
