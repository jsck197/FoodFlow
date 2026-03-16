package com.foodflow.service;

import com.foodflow.dao.UserDAO;
import com.foodflow.model.User;
import com.foodflow.util.PasswordUtil;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public boolean addUser(User user) {
        if (user == null || user.getUsername() == null || user.getUsername().isBlank()) {
            return false;
        }
        user.setPassword(PasswordUtil.hashPassword(user.getPassword()));
        return userDAO.addUser(user);
    }
}
