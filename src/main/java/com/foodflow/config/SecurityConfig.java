package com.foodflow.config;

import com.foodflow.model.User;

public class SecurityConfig {

    public static boolean isAdmin(User user) {
        return user != null && user.getRole() == User.Role.ADMIN;
    }

    public static boolean isManager(User user) {
        return user != null
                && (user.getRole() == User.Role.MANAGER || user.getRole() == User.Role.DEPARTMENT_HEAD);
    }

    public static boolean isClerk(User user) {
        return user != null
                && (user.getRole() == User.Role.CLERK || user.getRole() == User.Role.COOK);
    }

    public static boolean isAtLeastManager(User user) {
        return isAdmin(user) || isManager(user);
    }

    public static boolean hasPermission(User user, String permission) {
        if (user == null) {
            return false;
        }

        switch (permission) {
            case "MANAGE_USERS":
                return isAdmin(user);
            case "VIEW_REPORTS":
            case "ADD_ITEMS":
                return isAtLeastManager(user);
            case "RECORD_TRANSACTIONS":
                return true;
            default:
                return false;
        }
    }
}
