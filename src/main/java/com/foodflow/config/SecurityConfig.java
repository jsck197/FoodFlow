package com.foodflow.config;

import com.foodflow.model.User;

public class SecurityConfig {

    public static boolean isAdmin(User user) {
        return user != null && user.getRole() == User.Role.ADMIN;
    }

    public static boolean isDepartmentHead(User user) {
        return user != null && user.getRole() == User.Role.DEPARTMENT_HEAD;
    }

    public static boolean isStoreKeeper(User user) {
        return user != null && user.getRole() == User.Role.STORE_KEEPER;
    }

    public static boolean canViewReports(User user) {
        return isAdmin(user) || isDepartmentHead(user);
    }

    public static boolean canManageInventory(User user) {
        return isAdmin(user) || isStoreKeeper(user);
    }

    public static boolean canManageUsers(User user) {
        return isAdmin(user);
    }

    public static boolean canApproveRequests(User user) {
        return isAdmin(user) || isDepartmentHead(user);
    }

    public static boolean canCreateRequests(User user) {
        return isAdmin(user) || isStoreKeeper(user);
    }

    public static boolean canRecordOperationalData(User user) {
        return isAdmin(user) || isStoreKeeper(user);
    }

    public static boolean hasPermission(User user, String permission) {
        if (user == null) {
            return false;
        }

        switch (permission) {
            case "MANAGE_USERS":
                return canManageUsers(user);
            case "VIEW_REPORTS":
                return canViewReports(user);
            case "MANAGE_INVENTORY":
            case "ADD_ITEMS":
                return canManageInventory(user);
            case "APPROVE_REQUESTS":
                return canApproveRequests(user);
            case "CREATE_REQUESTS":
                return canCreateRequests(user);
            case "RECORD_TRANSACTIONS":
                return canRecordOperationalData(user);
            default:
                return false;
        }
    }
}
