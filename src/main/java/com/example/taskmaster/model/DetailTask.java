package com.example.taskmaster.model;

public class DetailTask {
    private int assignedUserId;
    private String assignUserFullName;
    private boolean isFollowing;
    private String colorLabel, nameLabel;

    public DetailTask(int assignedUserId, String assignUserFullName, boolean isFollowing, String colorLabel, String nameLabel) {
        this.assignedUserId = assignedUserId;
        this.assignUserFullName = assignUserFullName;
        this.isFollowing = isFollowing;
        this.colorLabel = colorLabel;
        this.nameLabel = nameLabel;
    }

    @Override
    public String toString() {
        return "DetailTask{" +
                "assignedUserId=" + assignedUserId +
                ", assignUserFullName=" + assignUserFullName +
                ", isFollowing=" + isFollowing +
                ", colorLabel='" + colorLabel + '\'' +
                ", nameLabel='" + nameLabel + '\'' +
                '}';
    }

    public int getAssignedUserId() {
        return assignedUserId;
    }

    public void setAssignedUserId(int assignedUserId) {
        this.assignedUserId = assignedUserId;
    }

    public String getAssignUserFullName() {
        return assignUserFullName;
    }

    public void setAssignUserFullName(String assignUserFullName) {
        this.assignUserFullName = assignUserFullName;
    }

    public boolean getIsFollowing() {
        return isFollowing;
    }

    public void setIsFollowing(boolean isFollowing) {
        this.isFollowing = isFollowing;
    }

    public String getColorLabel() {
        return colorLabel;
    }

    public void setColorLabel(String colorLabel) {
        this.colorLabel = colorLabel;
    }

    public String getNameLabel() {
        return nameLabel;
    }

    public void setNameLabel(String nameLabel) {
        this.nameLabel = nameLabel;
    }
}
