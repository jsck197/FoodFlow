<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodflow.model.Item" %>
<%@ page import="com.foodflow.model.Usage" %>
<%@ page import="com.foodflow.model.Damage" %>
<%@ page import="com.foodflow.model.StoreRequest" %>
<%
    List<Item> lowStockItems = (List<Item>) request.getAttribute("lowStockItems");
    List<Usage> usageReport = (List<Usage>) request.getAttribute("usageReport");
    List<Damage> damageReport = (List<Damage>) request.getAttribute("damageReport");
    List<StoreRequest> pendingRequests = (List<StoreRequest>) request.getAttribute("pendingRequests");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reports</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Reports</p>
            <h1>Department reporting view</h1>
            <p>Built around the Department Head and Admin reporting flow from your diagrams.</p>
        </div>
        <div class="nav-links">
            <a class="button secondary" href="../dashboard">Dashboard</a>
            <a class="button secondary" href="../requests">Requests</a>
        </div>
    </section>

    <section class="metrics">
        <article class="metric-card">
            <p class="eyebrow">Low stock items</p>
            <h2><%= lowStockItems != null ? lowStockItems.size() : 0 %></h2>
            <p class="muted">Items currently flagged for attention.</p>
        </article>
        <article class="metric-card">
            <p class="eyebrow">Issued item records</p>
            <h2><%= usageReport != null ? usageReport.size() : 0 %></h2>
            <p class="muted">Operational usage entries from the Store Keeper flow.</p>
        </article>
        <article class="metric-card">
            <p class="eyebrow">Pending requests</p>
            <h2><%= pendingRequests != null ? pendingRequests.size() : 0 %></h2>
            <p class="muted">Requests awaiting Department Head approval.</p>
        </article>
    </section>

    <section class="panel-grid">
        <article class="table-card">
            <h2>Low stock watchlist</h2>
            <table>
                <thead>
                <tr><th>Item</th><th>Category</th><th>Stock</th><th>Status</th></tr>
                </thead>
                <tbody>
                <% if (lowStockItems != null && !lowStockItems.isEmpty()) { %>
                    <% for (Item item : lowStockItems) { %>
                    <tr>
                        <td><%= item.getName() %></td>
                        <td><%= item.getCategory() %></td>
                        <td><%= item.getCurrentStock() %> <%= item.getUnitOfMeasure() %></td>
                        <td class="status-low"><%= item.getStatus() %></td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="4">No low stock items.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>

        <article class="table-card">
            <h2>Pending requests</h2>
            <table>
                <thead>
                <tr><th>Requester</th><th>Item</th><th>Qty</th><th>Status</th></tr>
                </thead>
                <tbody>
                <% if (pendingRequests != null && !pendingRequests.isEmpty()) { %>
                    <% for (StoreRequest requestItem : pendingRequests) { %>
                    <tr>
                        <td><%= requestItem.getRequesterName() %></td>
                        <td><%= requestItem.getItemName() %></td>
                        <td><%= requestItem.getQuantityRequested() %></td>
                        <td><%= requestItem.getStatus() %></td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="4">No pending requests.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>

        <article class="table-card">
            <h2>Issued items</h2>
            <table>
                <thead>
                <tr><th>Date</th><th>Item</th><th>Qty</th><th>Recorded By</th></tr>
                </thead>
                <tbody>
                <% if (usageReport != null && !usageReport.isEmpty()) { %>
                    <% for (Usage usage : usageReport) { %>
                    <tr>
                        <td><%= usage.getDate() %></td>
                        <td><%= usage.getItemName() %></td>
                        <td><%= usage.getQuantity() %></td>
                        <td><%= usage.getItemUserName() %></td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="4">No issued item records.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>

        <article class="table-card">
            <h2>Damage reports</h2>
            <table>
                <thead>
                <tr><th>Date</th><th>Item</th><th>Qty</th><th>Reported By</th></tr>
                </thead>
                <tbody>
                <% if (damageReport != null && !damageReport.isEmpty()) { %>
                    <% for (Damage damage : damageReport) { %>
                    <tr>
                        <td><%= damage.getDate() %></td>
                        <td><%= damage.getItemName() %></td>
                        <td><%= damage.getQuantity() %></td>
                        <td><%= damage.getReportedBy() %></td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="4">No damage records.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>
    </section>
</main>
</body>
</html>
