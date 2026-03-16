package com.foodflow.dao;

import com.foodflow.config.DatabaseConfig;
import com.foodflow.model.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    public boolean addItem(Item item) {
        String sql = "INSERT INTO items (name, category, stock, unit_of_measure, description, status) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, item.getName());
            stmt.setString(2, item.getCategory());
            stmt.setDouble(3, item.getCurrentStock());
            stmt.setString(4, item.getUnitOfMeasure());
            stmt.setString(5, item.getDescription());
            stmt.setString(6, normalizeStatus(item.getStatus(), item.getCurrentStock()));
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Item getItemById(int id) {
        String sql = "SELECT * FROM items WHERE item_id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? mapResultSetToItem(rs) : null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Item> getAllItems() {
        String sql = "SELECT * FROM items ORDER BY name ASC";
        List<Item> items = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                items.add(mapResultSetToItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public List<Item> searchItems(String query) {
        if (query == null || query.isBlank()) {
            return getAllItems();
        }

        String sql = "SELECT * FROM items WHERE LOWER(name) LIKE ? OR LOWER(category) LIKE ? ORDER BY name ASC";
        List<Item> items = new ArrayList<>();
        String term = "%" + query.trim().toLowerCase() + "%";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, term);
            stmt.setString(2, term);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(mapResultSetToItem(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET name=?, category=?, stock=?, unit_of_measure=?, description=?, status=? WHERE item_id=?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, item.getName());
            stmt.setString(2, item.getCategory());
            stmt.setDouble(3, item.getCurrentStock());
            stmt.setString(4, item.getUnitOfMeasure());
            stmt.setString(5, item.getDescription());
            stmt.setString(6, normalizeStatus(item.getStatus(), item.getCurrentStock()));
            stmt.setInt(7, item.getItemId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateItemStatus(int itemId, double currentStock, String status) {
        String sql = "UPDATE items SET stock = ?, status = ? WHERE item_id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setDouble(1, currentStock);
            stmt.setString(2, normalizeStatus(status, currentStock));
            stmt.setInt(3, itemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean adjustStock(int itemId, double delta) {
        Item item = getItemById(itemId);
        if (item == null) {
            return false;
        }
        double newStock = item.getCurrentStock() + delta;
        if (newStock < 0) {
            return false;
        }
        return updateItemStatus(itemId, newStock, item.getStatus());
    }

    private String normalizeStatus(String requestedStatus, double stock) {
        if (stock <= 0) {
            return "OUT_OF_STOCK";
        }
        if ("LOW_STOCK".equalsIgnoreCase(requestedStatus) || stock <= 10) {
            return "LOW_STOCK";
        }
        if (requestedStatus == null || requestedStatus.isBlank()) {
            return "AVAILABLE";
        }
        return requestedStatus.toUpperCase();
    }

    private Item mapResultSetToItem(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setItemId(rs.getInt("item_id"));
        item.setName(rs.getString("name"));
        item.setCategory(rs.getString("category"));
        item.setCurrentStock(rs.getDouble("stock"));
        item.setUnitOfMeasure(rs.getString("unit_of_measure"));
        item.setDescription(rs.getString("description"));
        item.setStatus(rs.getString("status"));
        return item;
    }
}
