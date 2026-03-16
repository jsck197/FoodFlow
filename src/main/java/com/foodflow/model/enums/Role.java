package com.foodflow.model.enums;

public enum Role {
    ADMIN,
    MANAGER,
    CLERK,
    DEPARTMENT_HEAD,
    COOK;

    public static Role from(String value) {
        if (value == null || value.isBlank()) {
            return CLERK;
        }
        return Role.valueOf(value.trim().toUpperCase());
    }
}
