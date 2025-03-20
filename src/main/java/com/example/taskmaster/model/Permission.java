package com.example.taskmaster.model;

public class Permission {
    private int permissionId;
    private String name;

    public Permission(int permissionId, String name) {
        this.permissionId = permissionId;
        this.name = name;
    }

    @Override
    public String toString() {
        return "Permission{" +
                "permissionId=" + permissionId +
                ", name='" + name + '\'' +
                '}';
    }

    public int getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(int permissionId) {
        this.permissionId = permissionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
