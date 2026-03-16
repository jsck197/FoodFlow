<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodflow.model.Item" %>
<%@ page import="com.foodflow.model.Supply" %>
<%
    List<Item> items = (List<Item>) request.getAttribute("items");
    List<Supply> supplies = (List<Supply>) request.getAttribute("supplies");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Supply Intake</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Supply Intake</p>
            <h1>Receive stock</h1>
            <p>Matches the Store Keeper flow for updating supplied food and utensils.</p>
        </div>
        <div class="nav-links">
            <a class="button secondary" href="../dashboard">Dashboard</a>
            <a class="button secondary" href="../items">Items</a>
        </div>
    </section>

    <% if (request.getAttribute("error") != null) { %>
    <section class="notice error"><%= request.getAttribute("error") %></section>
    <% } %>

    <section class="content-grid">
        <article class="form-card">
            <h2>Record supply</h2>
            <form method="post" action="../supplies">
                <label>
                    Item
                    <select name="itemId" required>
                        <% if (items != null) { for (Item item : items) { %>
                        <option value="<%= item.getItemId() %>"><%= item.getName() %> (<%= item.getCurrentStock() %> <%= item.getUnitOfMeasure() %>)</option>
                        <% }} %>
                    </select>
                </label>
                <label>Quantity<input type="number" name="quantity" step="1" min="1" required></label>
                <button type="submit">Add to inventory</button>
            </form>
        </article>

        <article class="table-card">
            <h2>Recent supply records</h2>
            <table>
                <thead>
                <tr><th>Date</th><th>Item</th><th>Qty</th><th>Supplier</th><th>Recorded By</th></tr>
                </thead>
                <tbody>
                <% if (supplies != null && !supplies.isEmpty()) { %>
                    <% for (Supply supply : supplies) { %>
                    <tr>
                        <td><%= supply.getDate() %></td>
                        <td><%= supply.getItemName() %></td>
                        <td><%= supply.getQuantity() %></td>
                        <td><%= supply.getSupplier() %></td>
                        <td><%= supply.getRecordedByName() %></td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="5">No supply records yet.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>
    </section>
</main>
</body>
</html>
