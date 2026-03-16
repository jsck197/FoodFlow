<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.foodflow.model.User" %>
<%
    User currentUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Department Head Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Department Head</p>
            <h1>Requests and reports</h1>
            <p>Approve store requests and review operational reports from the Store Keeper.</p>
        </div>
        <div class="toolbar">
            <a class="button secondary" href="../auth?action=logout">Log out</a>
        </div>
    </section>

    <section class="metrics">
        <article class="metric-card">
            <p class="eyebrow">Current user</p>
            <h2><%= currentUser != null ? currentUser.getFullName() : "Department Head" %></h2>
            <p class="muted">Role: <%= currentUser != null ? currentUser.getRole() : "DEPARTMENT_HEAD" %></p>
        </article>
        <article class="metric-card">
            <p class="eyebrow">Primary tools</p>
            <h2>2</h2>
            <p class="muted">Store request approvals and report review.</p>
        </article>
    </section>

    <section class="panel-grid">
        <article class="panel">
            <h2>Quick links</h2>
            <ul class="plain-list">
                <li><a href="../requests">Approve store requests</a></li>
                <li><a href="../reports">View reports</a></li>
            </ul>
        </article>
        <article class="panel">
            <h2>Expected flow</h2>
            <ul class="plain-list">
                <li>View pending requests from the Store Keeper.</li>
                <li>Approve or reject requests.</li>
                <li>Open reports and dashboard summaries.</li>
            </ul>
        </article>
    </section>
</main>
</body>
</html>
