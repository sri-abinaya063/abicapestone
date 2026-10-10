<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account - ABIMART Premium</title>
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
            overflow-y: auto;
        }
        @media (min-width: 1024px) {
            .auth-panel { max-width: 600px; }
        }
        .auth-form-wrapper {
            width: 100%;
            max-width: 420px;
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            padding: 2rem 0;
        }
        .auth-header {
            margin-bottom: 2rem;
        }
        .auth-header .nav-brand {
            margin-bottom: 1.5rem;
            justify-content: flex-start;
        }
        .auth-header h2 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }
        .auth-header p {
            color: var(--text-secondary);
        }
        
        .error-message {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error);
            padding: 1rem;
            border-radius: var(--radius-md);
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            display: none;
        }
        <% if(request.getAttribute("error") != null) { %>
        .error-message { display: block; }
        <% } %>
        
        /* Password Strength Indicator */
        .password-strength {
            height: 4px;
            background: var(--bg-tertiary);
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
            display: none; /* simple js demo below */
        }
        .password-strength-bar {
            height: 100%;
            width: 0;
            background: var(--error);
            transition: all 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="auth-layout">
        <div class="auth-visual">
            <div class="auth-visual-overlay"></div>
            <div class="auth-visual-content">
                <h1>Join the Club</h1>
                <p>Create an account to unlock exclusive deals, faster checkout, and a personalized shopping experience tailored just for you.</p>
            </div>
        </div>
        
        <div class="auth-panel">
            <div class="auth-form-wrapper">
                <div class="auth-header">
                    <a href="index.jsp" class="nav-brand">
                        <i class="fa-solid fa-cube" style="color: var(--accent);"></i>
                        ABIMART
                    </a>
                    <h2>Create Account</h2>
                    <p>Join ABIMART to get started.</p>
                </div>

                <div class="error-message">
                    <i class="fa-solid fa-circle-exclamation"></i> <%= request.getAttribute("error") != null ? request.getAttribute("error") : "Registration failed" %>
                </div>

                <form action="auth" method="post" id="registerForm">
                    <input type="hidden" name="action" value="register">
                    
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <div style="position: relative;">
                            <i class="fa-regular fa-user" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                            <input type="text" name="full_name" class="form-control" style="padding-left: 2.75rem;" placeholder="John Doe" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <div style="position: relative;">
                            <i class="fa-regular fa-envelope" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                            <input type="email" name="email" class="form-control" style="padding-left: 2.75rem;" placeholder="name@example.com" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Mobile Number</label>
                        <div style="position: relative;">
                            <i class="fa-solid fa-phone" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                            <input type="tel" name="mobile" class="form-control" style="padding-left: 2.75rem;" placeholder="+1 (555) 000-0000" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <div style="position: relative;">
                            <i class="fa-solid fa-lock" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
                            <input type="password" name="password" id="password" class="form-control" style="padding-left: 2.75rem;" placeholder="Create a strong password" required>
                        </div>
                        <div class="password-strength" id="pwdStrength" style="display: block;">
                            <div class="password-strength-bar" id="pwdBar"></div>
                        </div>
                        <div style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.25rem;">Must be at least 8 characters.</div>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">I want to join as a</label>
                        <div style="position: relative;">
                            <select name="role_id" class="form-control" style="appearance: none; cursor: pointer;">
                                <option value="1">Buyer (Shopping Account)</option>
                                <option value="2">Seller (Merchant Account)</option>
                            </select>
                            <i class="fa-solid fa-chevron-down" style="position: absolute; right: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted); pointer-events: none;"></i>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-block mt-2">Create Account</button>
                </form>
                
                <p class="text-center mt-4" style="color: var(--text-secondary); font-size: 0.95rem;">
                    Already have an account? <a href="login.jsp" style="font-weight: 600;">Sign In</a>
                </p>
            </div>
        </div>
    </div>
    
    <script>
        // Simple password strength meter
        document.getElementById('password').addEventListener('input', function(e) {
            const val = e.target.value;
            const bar = document.getElementById('pwdBar');
            if (val.length === 0) {
                bar.style.width = '0';
            } else if (val.length < 5) {
                bar.style.width = '33%';
                bar.style.backgroundColor = 'var(--error)';
            } else if (val.length < 8) {
                bar.style.width = '66%';
                bar.style.backgroundColor = 'var(--warning)';
            } else {
                bar.style.width = '100%';
                bar.style.backgroundColor = 'var(--success)';
            }
        });
    </script>
</body>
</html>
