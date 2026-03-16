package com.foodflow.dao;

import com.foodflow.config.DatabaseConfig;
import com.foodflow.model.User;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private final Connection conn;

    public UserDAO() {
        conn = DatabaseConfig.getConnection();
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT u.*, r.role_title FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.user_name = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUserById(int userId) {
        String sql = "SELECT u.*, r.role_title FROM users u JOIN roles r ON u.role_id = r.role_id WHERE u.user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT u.*, r.role_title FROM users u JOIN roles r ON u.role_id = r.role_id ORDER BY u.user_id";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO users (user_name, email_address, password_hash, role_id, is_active) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setInt(4, resolveRoleId(user.getRole()));
            stmt.setBoolean(5, user.isActive());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET user_name = ?, email_address = ?, password_hash = ?, role_id = ?, is_active = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setInt(4, resolveRoleId(user.getRole()));
            stmt.setBoolean(5, user.isActive());
            stmt.setInt(6, user.getUserId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void logUserActivity(int userId, String action, String module, String description, String ipAddress) {
        String sql = "INSERT INTO system_logs (user_id, action_performed, timestamp) VALUES (?, ?, CURRENT_TIMESTAMP)";
        String actionPerformed = String.format("%s [%s] - %s (ip=%s)", action, module, description, ipAddress);
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, actionPerformed);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Schema has no login_attempts column yet; keeping as safe no-op hooks.
    public void resetLoginAttempts(int userId) {
    }

    public void incrementLoginAttempts(String username) {
    }

    public void updateLastLogin(int userId) {
        String sql = "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private int resolveRoleId(User.Role role) throws SQLException {
        User.Role normalized = role == null ? User.Role.COOK : role;
        String roleTitle;
        switch (normalized) {
            case ADMIN:
                roleTitle = "ADMIN";
                break;
            case MANAGER:
            case DEPARTMENT_HEAD:
                roleTitle = "DEPARTMENT_HEAD";
                break;
            case CLERK:
            case COOK:
            default:
                roleTitle = "COOK";
                break;
        }

        String sql = "SELECT role_id FROM roles WHERE role_title = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, roleTitle);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("role_id");
                }
            }
        }
        throw new SQLException("Role not found for title: " + roleTitle);
    }

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        String name = rs.getString("user_name");
        user.setFullName(name);
        user.setUsername(name);
        user.setEmail(rs.getString("email_address"));
        user.setPassword(rs.getString("password_hash"));
        user.setRole(User.Role.valueOf(rs.getString("role_title")));
        user.setActive(rs.getBoolean("is_active"));

        Timestamp lastLoginTs = rs.getTimestamp("last_login");
        LocalDateTime lastLogin = lastLoginTs == null ? null : lastLoginTs.toLocalDateTime();
        user.setLastLogin(lastLogin);
        return user;
    }

   
}
