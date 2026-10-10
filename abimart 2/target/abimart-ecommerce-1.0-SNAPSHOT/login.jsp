<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - ABIMART Premium</title>
    <link rel="stylesheet" href="css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .auth-layout {
            display: flex;
            min-height: 100vh;
            background: var(--bg-main);
        }
        .auth-visual {
            flex: 1;
            display: none;
            position: relative;
            background: url('images/hero_banner.jpg') center/cover no-repeat;
        }
        @media (min-width: 1024px) {
            .auth-visual { display: flex; align-items: center; justify-content: center; }
        }
        .auth-visual-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(17, 24, 39, 0.9), rgba(67, 56, 202, 0.8));
            z-index: 1;
        }
        .auth-visual-content {
            position: relative;
            z-index: 2;
            color: white;
            max-width: 480px;
            padding: 3rem;
            animation: fadeIn 1s ease forwards;
        }
        .auth-visual-content h1 {
            color: white;
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        .auth-visual-content p {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        .auth-panel {
            flex: 1;
            max-width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background: var(--bg-main);
        }
        @media (min-width: 1024px) {
            .auth-panel { max-width: 600px; }
        }
        .auth-form-wrapper {
            width: 100%;
            max-width: 420px;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        }
        .auth-header {
            margin-bottom: 2.5rem;
        }
        .auth-header .nav-brand {
            margin-bottom: 2rem;
            justify-content: flex-start;
        }
        .auth-header h2 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        .auth-header p {
            color: var(--text-secondary);
        }
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 1.5rem 0;
            font-size: 0.9rem;
        }
        .auth-divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 2rem 0;
            color: var(--text-muted);
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .auth-divider::before, .auth-divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid var(--border-color);
        }
        .auth-divider::not(:empty)::before { margin-right: .5em; }
        .auth-divider::not(:empty)::after { margin-left: .5em; }
        
        .error-message {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error);
            padding: 1rem;
            border-radius: var(--radius-md);
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            display: none; /* Show dynamically via JSP if error exists */
        }
        <% if(request.getAttribute("error") != null) { %>
        .error-message { display: block; }
        <% } %>
    </style>
</head>
<body>
    <div class="auth-layout">
        <div class="auth-visual">
            <div class="auth-visual-overlay"></div>
            <div class="auth-visual-content">
                <h1>Welcome Back</h1>
                <p>Sign in to access your personalized shopping experience, track orders, and discover new premium products.</p>
            </div>
        </div>
        
        <div class="auth-panel">
            <div class="auth-form-wrapper">
                <div class="auth-header">
                    <a href="index.jsp" class="nav-brand">
                        <i class="fa-solid fa-cube" style="color: var(--accent);"></i>
                        ABIMART
                    </a>
                    <h2>Sign In</h2>
                    <p>Enter your details below to access your account</p>
                </div>

                <div class="error-message">
                    <i class="fa-solid fa-circle-exclamation"></i> <%= request.getAttribute("error") != null ? request.getAttribute("error") : "Invalid credentials" %>
                </div>

                <form action="auth" method="post">
                    <input type="hidden" name="action" value="login">
                    
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <div style="position: relative;">
                            <i class="fa-regular fa-envelope" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                            <input type="email" name="email" class="form-control" style="padding-left: 2.75rem;" placeholder="name@example.com" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <div style="position: relative;">
                            <i class="fa-solid fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                            <input type="password" name="password" class="form-control" style="padding-left: 2.75rem;" placeholder="••••••••" required>
                        </div>
                    </div>
                    
                    <div class="form-options">
                        <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                            <input type="checkbox" style="accent-color: var(--accent);"> Remember me
                        </label>
                        <a href="forgot-password.jsp" style="font-weight: 500;">Forgot Password?</a>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                </form>
                
                <div class="auth-divider">Or</div>
                
                <p class="text-center" style="color: var(--text-secondary); font-size: 0.95rem;">
                    Don't have an account? <a href="register.jsp" style="font-weight: 600;">Create Account</a>
                </p>
            </div>
        </div>
    </div>
</body>
</html>
