<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodflow.model.SystemLog" %>
<%
    List<SystemLog> logs = (List<SystemLog>) request.getAttribute("logs");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin System Operations</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Admin System</p>
            <h1>Database operations and logs</h1>
            <p>Matches the admin flowchart for backup, restore, maintenance, and activity log review.</p>
        </div>
        <div class="nav-links">
            <a class="button secondary" href="dashboard.jsp">Dashboard</a>
            <a class="button secondary" href="users">Users</a>
        </div>
    </section>

    <section class="panel-grid">
        <article class="form-card">
            <h2>Database operations</h2>
            <form method="post" action="system">
                <button type="submit" name="action" value="backup">Backup database</button>
                <button type="submit" name="action" value="restore">Restore database</button>
                <button type="submit" name="action" value="maintenance">System maintenance</button>
            </form>
        </article>

        <article class="table-card">
            <h2>Activity log</h2>
            <table>
                <thead>
                <tr><th>When</th><th>User</th><th>Action</th></tr>
                </thead>
                <tbody>
                <% if (logs != null && !logs.isEmpty()) { %>
                    <% for (SystemLog log : logs) { %>
                    <tr>
                        <td><%= log.getTimestamp() %></td>
                        <td><%= log.getUserName() %></td>
                        <td><%= log.getAction() %></td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="3">No activity logs available.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>
    </section>
</main>
</body>
</html>
