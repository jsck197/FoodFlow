<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodflow.model.Item" %>
<%@ page import="com.foodflow.model.StoreRequest" %>
<%
    List<Item> items = (List<Item>) request.getAttribute("items");
    List<StoreRequest> requests = (List<StoreRequest>) request.getAttribute("requests");
    Boolean canApproveRequests = (Boolean) request.getAttribute("canApproveRequests");
    Boolean canCreateRequests = (Boolean) request.getAttribute("canCreateRequests");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Store Requests</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Store Requests</p>
            <h1>Request and approval workflow</h1>
            <p>Store Keeper creates requests, Department Head approves or rejects them.</p>
        </div>
        <div class="nav-links">
            <a class="button secondary" href="../dashboard">Dashboard</a>
            <a class="button secondary" href="../reports">Reports</a>
        </div>
    </section>

    <section class="content-grid">
        <% if (Boolean.TRUE.equals(canCreateRequests)) { %>
        <article class="form-card">
            <h2>Create request</h2>
            <form method="post" action="../requests">
                <input type="hidden" name="action" value="create">
                <label>
                    Item
                    <select name="itemId" required>
                        <% if (items != null) { for (Item item : items) { %>
                        <option value="<%= item.getItemId() %>"><%= item.getName() %></option>
                        <% }} %>
                    </select>
                </label>
                <label>Quantity requested<input type="number" name="quantity" step="1" min="1" required></label>
                <label>Notes<textarea name="notes" placeholder="Reason for request"></textarea></label>
                <button type="submit">Submit pending request</button>
            </form>
        </article>
        <% } %>

        <article class="table-card">
            <h2>Request list</h2>
            <table>
                <thead>
                <tr><th>Date</th><th>Requester</th><th>Item</th><th>Qty</th><th>Status</th><th>Actions</th></tr>
                </thead>
                <tbody>
                <% if (requests != null && !requests.isEmpty()) { %>
                    <% for (StoreRequest requestItem : requests) { %>
                    <tr>
                        <td><%= requestItem.getRequestDate() %></td>
                        <td><%= requestItem.getRequesterName() %></td>
                        <td><%= requestItem.getItemName() %></td>
                        <td><%= requestItem.getQuantityRequested() %></td>
                        <td><%= requestItem.getStatus() %></td>
                        <td>
                            <% if (Boolean.TRUE.equals(canApproveRequests) && "PENDING".equalsIgnoreCase(requestItem.getStatus())) { %>
                            <form method="post" action="../requests" class="split">
                                <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
                                <button type="submit" name="action" value="approve">Approve</button>
                            </form>
                            <form method="post" action="../requests" class="split">
                                <input type="hidden" name="requestId" value="<%= requestItem.getRequestId() %>">
                                <button type="submit" name="action" value="reject">Reject</button>
                            </form>
                            <% } else { %>
                            <span class="muted">No action</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="6">No requests available.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>
    </section>
</main>
</body>
</html>
