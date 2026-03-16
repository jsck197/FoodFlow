package com.foodflow.dao;

import com.foodflow.config.DatabaseConfig;
import com.foodflow.model.Usage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UsageDAO {

    public boolean addUsage(Usage usage) {
        String insertSql = "INSERT INTO borrow_transactions (item_id, quantity_borrowed, quantity_returned, borrow_date, return_date, status, recorded_by) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String stockSql = "UPDATE items SET stock = stock - ?, status = CASE WHEN stock - ? <= 0 THEN 'OUT_OF_STOCK' WHEN stock - ? <= 10 THEN 'LOW_STOCK' ELSE 'AVAILABLE' END WHERE item_id = ? AND stock >= ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement insertStmt = conn.prepareStatement(insertSql);
             PreparedStatement stockStmt = conn.prepareStatement(stockSql)) {
            conn.setAutoCommit(false);
            insertStmt.setInt(1, usage.getItemId());
            insertStmt.setDouble(2, usage.getQuantity());
            insertStmt.setDouble(3, usage.getQuantityReturned());
            insertStmt.setTimestamp(4, Timestamp.valueOf(LocalDateTime.of(usage.getDate(), java.time.LocalTime.NOON)));
            insertStmt.setTimestamp(5, null);
            insertStmt.setString(6, usage.getStatus().name());
            insertStmt.setInt(7, usage.getRecordedBy());
            insertStmt.executeUpdate();

            stockStmt.setDouble(1, usage.getQuantity());
            stockStmt.setDouble(2, usage.getQuantity());
            stockStmt.setDouble(3, usage.getQuantity());
            stockStmt.setInt(4, usage.getItemId());
            stockStmt.setDouble(5, usage.getQuantity());
            if (stockStmt.executeUpdate() == 0) {
                conn.rollback();
                return false;
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Usage> getAllUsage() {
        String sql = "SELECT b.*, i.name AS item_name, u.name AS recorded_by_name " +
                "FROM borrow_transactions b JOIN items i ON b.item_id = i.item_id " +
                "JOIN users u ON b.recorded_by = u.user_id ORDER BY b.borrow_date DESC";
        List<Usage> usageList = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                usageList.add(mapResultSetToUsage(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usageList;
    }

    public boolean recordUsage(String itemId, int quantity, int userId) {
        try {
            return recordUsage(Integer.parseInt(itemId), quantity, userId);
        } catch (NumberFormatException ex) {
            return false;
        }
    }

    public boolean recordUsage(int itemId, double quantity, int userId) {
        Usage usage = new Usage();
        usage.setItemId(itemId);
        usage.setQuantity(quantity);
        usage.setRecordedBy(userId);
        usage.setStatus(Usage.Status.ISSUED);
        return addUsage(usage);
    }

    private Usage mapResultSetToUsage(ResultSet rs) throws SQLException {
        Usage usage = new Usage();
        usage.setUsageId(rs.getInt("borrow_id"));
        usage.setItemId(rs.getInt("item_id"));
        usage.setItemName(rs.getString("item_name"));
        usage.setQuantity(rs.getDouble("quantity_borrowed"));
        usage.setQuantityReturned(rs.getDouble("quantity_returned"));
        usage.setRecordedBy(rs.getInt("recorded_by"));
        usage.setItemUserName(rs.getString("recorded_by_name"));
        Timestamp timestamp = rs.getTimestamp("borrow_date");
        if (timestamp != null) {
            usage.setDate(timestamp.toLocalDateTime().toLocalDate());
        }
        usage.setStatus(Usage.Status.valueOf(rs.getString("status")));
        return usage;
    }
}
