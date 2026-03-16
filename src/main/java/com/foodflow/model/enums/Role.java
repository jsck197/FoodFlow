package com.foodflow.model.enums;

public enum Role {
    ADMIN,
    DEPARTMENT_HEAD,
    STORE_KEEPER;

    public static Role from(String value) {
        if (value == null || value.isBlank()) {
            return STORE_KEEPER;
        }
        return Role.valueOf(value.trim().toUpperCase());
    }
}
