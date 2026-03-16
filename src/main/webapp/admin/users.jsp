<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodflow.model.User" %>
<%
    List<User> users = (List<User>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Admin</p>
            <h1>User management</h1>
            <p>Admin-only add, update, and delete flow for the 3-role system.</p>
        </div>
        <div class="nav-links">
            <a class="button primary" href="users?action=add">Add user</a>
            <a class="button secondary" href="dashboard.jsp">Dashboard</a>
        </div>
    </section>

    <section class="table-card">
        <table>
            <thead>
            <tr><th>ID</th><th>Name</th><th>Role</th><th>Email</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <% if (users != null && !users.isEmpty()) { %>
                <% for (User user : users) { %>
                <tr>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getFullName() %></td>
                    <td><%= user.getRole() %></td>
                    <td><%= user.getEmail() %></td>
                    <td>
                        <a href="users?action=edit&id=<%= user.getUserId() %>">Edit</a>
                        <span class="muted">|</span>
                        <a class="danger" href="users?action=delete&id=<%= user.getUserId() %>">Delete</a>
                    </td>
                </tr>
                <% } %>
            <% } else { %>
                <tr><td colspan="5">No users found.</td></tr>
            <% } %>
            </tbody>
        </table>
    </section>
</main>
</body>
</html>
