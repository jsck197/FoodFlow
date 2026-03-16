<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.foodflow.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Store Keeper Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Store Keeper</p>
            <h1>Inventory operations</h1>
            <p>Update stock, issue items, record damage, and submit requests to the Department Head.</p>
        </div>
        <div class="toolbar">
            <a class="button secondary" href="../auth?action=logout">Log out</a>
        </div>
    </section>

    <section class="panel-grid">
        <article class="panel">
            <h2>Current user</h2>
            <p><strong><%= currentUser != null ? currentUser.getFullName() : "Store Keeper" %></strong></p>
            <p class="muted">Role: <%= currentUser != null ? currentUser.getRole() : "STORE_KEEPER" %></p>
        </article>
        <article class="panel">
            <h2>Operational links</h2>
            <ul class="plain-list">
                <li><a href="../items">Manage inventory</a></li>
                <li><a href="../supplies">Receive stock</a></li>
                <li><a href="../usage">Record issued items</a></li>
                <li><a href="../damage">Record damages</a></li>
                <li><a href="../requests">Make store requests</a></li>
            </ul>
        </article>
    </section>
</main>
</body>
</html>
