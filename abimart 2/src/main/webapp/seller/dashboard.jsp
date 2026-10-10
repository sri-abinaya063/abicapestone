<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard - ABIMART</title>
    <link rel="stylesheet" href="../css/premium.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .dashboard-layout {
            display: grid;
            grid-template-columns: 260px 1fr;
            min-height: 100vh;
        }
        @media (max-width: 1024px) {
            .dashboard-layout { grid-template-columns: 1fr; }
            .sidebar { display: none; }
        }
        .sidebar {
            background: var(--bg-main);
            border-right: 1px solid var(--border-color);
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
        }
        .sidebar-brand {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 3rem;
            padding-left: 0.5rem;
        }
        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            flex: 1;
        }
        .sidebar-nav a {
            color: var(--text-secondary);
            padding: 0.875rem 1rem;
            border-radius: var(--radius-md);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all var(--transition-fast);
        }
        .sidebar-nav a:hover {
            background: var(--bg-secondary);
            color: var(--text-primary);
        }
        .sidebar-nav a.active {
            background: var(--bg-tertiary);
            color: var(--accent);
        }
        .sidebar-nav a i { width: 20px; text-align: center; }
        
        .main-content {
            background: var(--bg-secondary);
            padding: 2rem 3rem;
            overflow-y: auto;
        }
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: var(--bg-main);
            padding: 1.5rem;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
        }
        .stat-card-header {
            display: flex;
            justify-content: space-between;
            color: var(--text-secondary);
            margin-bottom: 1rem;
            font-weight: 500;
        }
        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
        }
        .recent-section {
            background: var(--bg-main);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-color);
            padding: 2rem;
        }
    </style>
</head>
<body>
    <div class="dashboard-layout">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-brand">
                <i class="fa-solid fa-cube" style="color: var(--accent);"></i>
                ABIMART <span style="font-size: 0.8rem; background: var(--bg-tertiary); color: var(--text-secondary); padding: 2px 6px; border-radius: 4px;">Seller</span>
            </div>
            <div class="sidebar-nav">
                <a href="dashboard.jsp" class="active"><i class="fa-solid fa-chart-line"></i> Overview</a>
                <a href="manage_products.jsp"><i class="fa-solid fa-box-open"></i> My Products</a>
                <a href="add_product.jsp"><i class="fa-solid fa-plus"></i> Add Product</a>
                <a href="view_orders.jsp"><i class="fa-solid fa-clipboard-list"></i> Customer Orders</a>
            </div>
            <div class="sidebar-nav" style="flex: 0; margin-top: 2rem;">
                <a href="../auth?action=logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="topbar">
                <div>
                    <h1 style="font-size: 1.75rem;">Seller Dashboard</h1>
                    <p class="text-secondary">Here's what's happening with your store today.</p>
                </div>
                <div style="display: flex; gap: 1rem;">
                    <a href="add_product.jsp" class="btn btn-primary"><i class="fa-solid fa-plus"></i> New Product</a>
                </div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-card-header">Total Sales <i class="fa-solid fa-dollar-sign"></i></div>
                    <div class="stat-value">$12,450.00</div>
                    <div class="text-sm" style="color: var(--success); margin-top: 0.5rem;"><i class="fa-solid fa-arrow-trend-up"></i> +15% from last week</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">Pending Orders <i class="fa-solid fa-box"></i></div>
                    <div class="stat-value">24</div>
                    <div class="text-sm text-secondary" style="margin-top: 0.5rem;">Requires fulfillment</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">Active Products <i class="fa-solid fa-tag"></i></div>
                    <div class="stat-value">145</div>
                    <div class="text-sm text-secondary" style="margin-top: 0.5rem;">In 5 categories</div>
                </div>
            </div>
            
            <div class="recent-section">
                <h3 style="margin-bottom: 1.5rem;">Recent Orders</h3>
                <p class="text-secondary">No new orders in the last 24 hours.</p>
            </div>
        </div>
    </div>
</body>
</html>
