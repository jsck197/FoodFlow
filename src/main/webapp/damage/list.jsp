<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodflow.model.Item" %>
<%@ page import="com.foodflow.model.Damage" %>
<%
    List<Item> items = (List<Item>) request.getAttribute("items");
    List<Damage> damageEntries = (List<Damage>) request.getAttribute("damageEntries");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Damage Log</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Damages</p>
            <h1>Record damaged items</h1>
            <p>Supports the Store Keeper flow for logging damaged utensils and stock items.</p>
        </div>
        <div class="nav-links">
            <a class="button secondary" href="../dashboard">Dashboard</a>
            <a class="button secondary" href="../usage">Issued items</a>
        </div>
    </section>

    <% if (request.getAttribute("error") != null) { %>
    <section class="notice error"><%= request.getAttribute("error") %></section>
    <% } %>

    <section class="content-grid">
        <article class="form-card">
            <h2>Log damage</h2>
            <form method="post" action="../damage">
                <label>
                    Item
                    <select name="itemId" required>
                        <% if (items != null) { for (Item item : items) { %>
                        <option value="<%= item.getItemId() %>"><%= item.getName() %></option>
                        <% }} %>
                    </select>
                </label>
                <label>Quantity<input type="number" name="quantity" step="1" min="1" required></label>
                <label>Reason<textarea name="reason" required></textarea></label>
                <button type="submit">Log damage details</button>
            </form>
        </article>

        <article class="table-card">
            <h2>Damage records</h2>
            <table>
                <thead>
                <tr><th>Date</th><th>Item</th><th>Qty</th><th>Description</th><th>Reported By</th></tr>
                </thead>
                <tbody>
                <% if (damageEntries != null && !damageEntries.isEmpty()) { %>
                    <% for (Damage damage : damageEntries) { %>
                    <tr>
                        <td><%= damage.getDate() %></td>
                        <td><%= damage.getItemName() %></td>
                        <td><%= damage.getQuantity() %></td>
                        <td><%= damage.getDescription() %></td>
                        <td><%= damage.getReportedBy() %></td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="5">No damage reports yet.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>
    </section>
</main>
</body>
</html>
