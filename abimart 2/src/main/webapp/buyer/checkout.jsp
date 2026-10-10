<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure Checkout - ABIMART</title>
    <link rel="stylesheet" href="../css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .checkout-layout {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
            margin-top: 2rem;
        }
        @media (min-width: 1024px) {
            .checkout-layout { grid-template-columns: 1.5fr 1fr; }
        }
        .checkout-steps {
            background: var(--bg-main);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-xl);
            padding: 3rem;
            box-shadow: var(--shadow-sm);
        }
        .checkout-summary {
            background: var(--bg-secondary);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-xl);
            padding: 2rem;
            box-shadow: var(--shadow-md);
            position: sticky;
            top: 100px;
            height: fit-content;
        }
        .step-title {
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .step-number {
            background: var(--accent);
            color: white;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            font-weight: 700;
        }
        .radio-card {
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            padding: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all var(--transition-fast);
        }
        .radio-card:hover {
            border-color: var(--accent);
            background: var(--bg-secondary);
        }
        input[type="radio"] { accent-color: var(--accent); }
    </style>
</head>
<body style="background: var(--bg-secondary);">
    <!-- Navigation -->
    <nav class="navbar">
        <a href="../index.jsp" class="nav-brand">
            <i class="fa-solid fa-cube" style="color: var(--accent);"></i>
            ABIMART <span style="color: var(--text-muted); font-size: 1rem; font-weight: 500; margin-left: 1rem;">Secure Checkout</span>
        </a>
        <div class="nav-links">
            <a href="cart.jsp">Return to Cart</a>
        </div>
    </nav>

    <!-- Checkout Content -->
    <div class="container" style="padding: 3rem 5%; min-height: 70vh;">
        <div class="checkout-layout">
            <div class="checkout-steps">
                <form action="../OrderServlet" method="post">
                    <input type="hidden" name="action" value="placeOrder">
                    
                    <!-- Step 1: Shipping Address -->
                    <div style="margin-bottom: 3rem;">
                        <h3 class="step-title"><span class="step-number">1</span> Shipping Address</h3>
                        <div class="form-group">
                            <label class="form-label">Full Address</label>
                            <input type="text" name="address" class="form-control" placeholder="123 Premium St, Suite 400" required>
                        </div>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                            <div class="form-group">
                                <label class="form-label">City</label>
                                <input type="text" name="city" class="form-control" placeholder="New York" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label">ZIP / Postal Code</label>
                                <input type="text" name="zip" class="form-control" placeholder="10001" required>
                            </div>
                        </div>
                    </div>

                    <!-- Step 2: Payment Method -->
                    <div>
                        <h3 class="step-title"><span class="step-number">2</span> Payment Method</h3>
                        
                        <label class="radio-card">
                            <input type="radio" name="payment" value="card" checked>
                            <div style="flex: 1;">
                                <div style="font-weight: 600;">Credit / Debit Card</div>
                                <div class="text-muted text-sm">Secure payment via Stripe</div>
                            </div>
                            <i class="fa-brands fa-cc-visa" style="font-size: 1.5rem; color: #1434CB;"></i>
                            <i class="fa-brands fa-cc-mastercard" style="font-size: 1.5rem; color: #EB001B;"></i>
                        </label>

                        <label class="radio-card">
                            <input type="radio" name="payment" value="cod">
                            <div style="flex: 1;">
                                <div style="font-weight: 600;">Cash on Delivery</div>
                                <div class="text-muted text-sm">Pay when you receive the package</div>
                            </div>
                            <i class="fa-solid fa-money-bill-wave" style="font-size: 1.5rem; color: var(--success);"></i>
                        </label>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block mt-4" style="padding: 1.25rem; font-size: 1.1rem;">
                        Confirm and Place Order
                    </button>
                </form>
            </div>
            
            <div class="checkout-summary">
                <h3 style="margin-bottom: 1.5rem; font-size: 1.25rem;">Order Summary</h3>
                <div style="display: flex; justify-content: space-between; margin-bottom: 1rem; color: var(--text-secondary);">
                    <span>Subtotal</span>
                    <span>$0.00</span>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 1rem; color: var(--text-secondary);">
                    <span>Shipping</span>
                    <span>Free</span>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 1rem; color: var(--success);">
                    <span>Discounts</span>
                    <span>-$0.00</span>
                </div>
                <hr style="border: 0; border-top: 1px solid var(--border-color); margin: 1.5rem 0;">
                <div style="display: flex; justify-content: space-between; margin-bottom: 2rem; font-size: 1.5rem; font-weight: 700;">
                    <span>Total</span>
                    <span>$0.00</span>
                </div>
                
                <div class="text-center mt-4 text-sm text-muted">
                    <p>By placing your order, you agree to ABIMART's <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
