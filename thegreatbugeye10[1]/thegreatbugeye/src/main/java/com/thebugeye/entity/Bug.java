package com.thebugeye.entity;

public class Bug {
    private int id;
    private String title;
    private String description;
    private String status;
    private String priority;
    private String userId;
    private String reportedBy;
    private String assignedTo;

    // Constructor
    public Bug(String title, String description, String userId) {
        this.title = title;
        this.description = description;
        this.userId = userId;
        this.status = "Open"; 
    }

    // Overloaded constructor
    public Bug(int id, String title, String description, String status, String priority, String userId, String reportedBy, String assignedTo) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.status = status;
        this.priority = priority;
        this.userId = userId;
        this.reportedBy = reportedBy;
        this.assignedTo = assignedTo;
    }

    // Default constructor
    public Bug() {}

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getReportedBy() {
        return reportedBy;
    }

    public void setReportedBy(String reportedBy) {
        this.reportedBy = reportedBy;
    }

    public String getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(String assignedTo) {
        this.assignedTo = assignedTo;
    }

    @Override
    public String toString() {
        return "Bug{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                ", priority='" + priority + '\'' +
                ", userId='" + userId + '\'' +
                ", reportedBy='" + reportedBy + '\'' +
                ", assignedTo='" + assignedTo + '\'' +
                '}';
    }
}
