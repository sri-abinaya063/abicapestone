<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ABIMART</title>
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
            background: var(--primary);
            color: white;
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
        }
        .sidebar-brand {
            font-size: 1.5rem;
            font-weight: 800;
            color: white;
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
            color: #94a3b8;
            padding: 0.875rem 1rem;
            border-radius: var(--radius-md);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: all var(--transition-fast);
        }
        .sidebar-nav a:hover, .sidebar-nav a.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
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
                ABIMART
            </div>
            <div class="sidebar-nav">
                <a href="dashboard.jsp" class="active"><i class="fa-solid fa-chart-pie"></i> Overview</a>
                <a href="manage_users.jsp"><i class="fa-solid fa-users"></i> Users</a>
                <a href="manage_sellers.jsp"><i class="fa-solid fa-store"></i> Sellers</a>
                <a href="manage_categories.jsp"><i class="fa-solid fa-tags"></i> Categories</a>
                <a href="manage_orders.jsp"><i class="fa-solid fa-box"></i> Orders</a>
            </div>
            <div class="sidebar-nav" style="flex: 0; margin-top: 2rem;">
                <a href="../auth?action=logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="topbar">
                <div>
                    <h1 style="font-size: 1.75rem;">Dashboard</h1>
                    <p class="text-secondary">Welcome back, Admin.</p>
                </div>
                <div style="display: flex; gap: 1rem;">
                    <button class="btn btn-primary"><i class="fa-solid fa-download"></i> Report</button>
                </div>
            </div>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-card-header">Total Revenue <i class="fa-solid fa-dollar-sign"></i></div>
                    <div class="stat-value">$45,231.89</div>
                    <div class="text-sm" style="color: var(--success); margin-top: 0.5rem;"><i class="fa-solid fa-arrow-trend-up"></i> +20.1% from last month</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">Active Users <i class="fa-solid fa-users"></i></div>
                    <div class="stat-value">2,350</div>
                    <div class="text-sm" style="color: var(--success); margin-top: 0.5rem;"><i class="fa-solid fa-arrow-trend-up"></i> +180 new users</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">Sales <i class="fa-solid fa-credit-card"></i></div>
                    <div class="stat-value">+12,234</div>
                    <div class="text-sm" style="color: var(--success); margin-top: 0.5rem;"><i class="fa-solid fa-arrow-trend-up"></i> +19% from last month</div>
                </div>
                <div class="stat-card">
                    <div class="stat-card-header">Active Sellers <i class="fa-solid fa-store"></i></div>
                    <div class="stat-value">142</div>
                    <div class="text-sm text-secondary" style="margin-top: 0.5rem;">Total verified merchants</div>
                </div>
            </div>
            
            <div class="recent-section">
                <h3 style="margin-bottom: 1.5rem;">Recent Platform Activity</h3>
                <p class="text-secondary">System is running optimally. Select an option from the sidebar to manage platform entities.</p>
            </div>
        </div>
    </div>
</body>
</html>
