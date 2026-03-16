package com.foodflow.service;

import com.foodflow.dao.UsageDAO;

public class UsageService {
    private final UsageDAO usageDAO = new UsageDAO();

    public boolean recordUsage(int itemId, double quantity, int userId) {
        if (itemId <= 0 || quantity <= 0 || userId <= 0) {
            return false;
        }
        return usageDAO.recordUsage(itemId, quantity, userId);
    }
}
