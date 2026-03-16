package com.foodflow.model;

import java.time.LocalDate;

public class Usage {

    public enum Status {
        TAKEN,
        RETURNED
    }

    private int usageId;
    private int itemId;
    private double quantity;
    private String itemUserName;
    private LocalDate date = LocalDate.now();
    private Status status = Status.TAKEN;

    public int getUsageId() { return usageId; }
    public void setUsageId(int usageId) { this.usageId = usageId; }

    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public String getItemUserName() { return itemUserName; }
    public void setItemUserName(String itemUserName) { this.itemUserName = itemUserName; }

    public LocalDate getDate() { return date; }
    public void setDate(LocalDate date) { this.date = date; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }
}
