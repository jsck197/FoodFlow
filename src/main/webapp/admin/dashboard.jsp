<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.foodflow.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Admin Dashboard</p>
            <h1>System overview</h1>
            <p>Admin handles user management, system maintenance, database operations, and activity logs.</p>
        </div>
        <div class="toolbar">
            <a class="button secondary" href="../auth?action=logout">Log out</a>
        </div>
    </section>

    <section class="metrics">
        <article class="metric-card">
            <p class="eyebrow">Current user</p>
            <h2><%= currentUser != null ? currentUser.getFullName() : "Admin session" %></h2>
            <p class="muted">Role: <%= currentUser != null ? currentUser.getRole() : "ADMIN" %></p>
        </article>
        <article class="metric-card">
            <p class="eyebrow">System scope</p>
            <h2>3 users</h2>
            <p class="muted">One user per diagram-defined role.</p>
        </article>
        <article class="metric-card">
            <p class="eyebrow">Last refreshed</p>
            <h2 data-now>Loading...</h2>
            <p class="muted">Client-side timestamp for quick smoke testing.</p>
        </article>
    </section>

    <section class="panel-grid">
        <article class="panel">
            <h2>Operations</h2>
            <ul class="plain-list">
                <li><a href="../items">Open inventory</a></li>
                <li><a href="../supplies">Review stock intake</a></li>
                <li><a href="../usage">Review issued items</a></li>
                <li><a href="../damage">Review damage logs</a></li>
                <li><a href="../requests">Review requests</a></li>
                <li><a href="../reports">View reports</a></li>
                <li><a href="users">Manage users</a></li>
                <li><a href="../admin/system">System operations</a></li>
            </ul>
        </article>
        <article class="panel">
            <h2>Admin flow</h2>
            <ul class="plain-list">
                <li>Manage users: add, update, and delete users.</li>
                <li>Database operations: backup and restore placeholders are now routed through the backend.</li>
                <li>System logs and maintenance actions are captured through admin system operations.</li>
            </ul>
        </article>
    </section>
</main>
<script src="../assets/js/app.js"></script>
</body>
</html>
