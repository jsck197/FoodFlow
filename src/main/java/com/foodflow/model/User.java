package com.foodflow.model;


import com.foodflow.model.enums.Role;

import java.time.LocalDateTime;

public class User {

    public enum Role {
        ADMIN,
        MANAGER,
        CLERK,
        DEPARTMENT_HEAD,
        COOK
    }

    private int userId;
    private String fullName;
    private String username;
    private String email;
    private String password;
    private Role role = Role.CLERK;
    private boolean active = true;
    private boolean accountLocked;
    private int loginAttempts;
    private LocalDateTime lastLogin;

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role == null ? Role.CLERK : role; }
    public void setRole(com.foodflow.model.enums.Role role) {
        this.role = role == null ? Role.CLERK : Role.valueOf(role.name());
    }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public boolean isAccountLocked() { return accountLocked || loginAttempts >= 5; }
    public void setAccountLocked(boolean accountLocked) { this.accountLocked = accountLocked; }

    public int getLoginAttempts() { return loginAttempts; }
    public void setLoginAttempts(int loginAttempts) { this.loginAttempts = loginAttempts; }

    public LocalDateTime getLastLogin() { return lastLogin; }
    public void setLastLogin(LocalDateTime lastLogin) { this.lastLogin = lastLogin; }
}
