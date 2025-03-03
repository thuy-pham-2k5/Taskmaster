package com.example.taskmaster.model;

public class User {
    private int userId;
    private String email, password, username, cv, fullName, publicName, title, department, organization, address;
    private int roleId;
    private String roleName;

    public User(String email, String password, String fullName) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
    }

    public User(int userId, String fullName, String username) {
        this.userId = userId;
        this.username = username;
        this.fullName = fullName;
    }

    public User (int userId, String email, String password, int roleId, String roleName) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.roleId = roleId;
        this.roleName = roleName;
    }

    public User(int userId, String fullName, String username, String roleName) {
        this.userId = userId;
        this.fullName = fullName;
        this.username = username;
        this.roleName = roleName;
    }

    public User(int userId, String email, String username, String publicName, int roleId, String roleName) {
        this.userId = userId;
        this.email = email;
        this.username = username;
        this.publicName = publicName;
        this.roleId = roleId;
        this.roleName = roleName;
    }



    public User (int userId, String email, String password, String username, String cv, String fullName, String publicName, String title, String department, String organization, String address, int roleId, String roleName) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.username = username;
        this.cv = cv;
        this.fullName = fullName;
        this.publicName = publicName;
        this.title = title;
        this.department = department;
        this.organization = organization;
        this.address = address;
        this.roleId = roleId;
        this.roleName = roleName;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", gmail='" + email + '\'' +
                ", password='" + password + '\'' +
                ", username='" + username + '\'' +
                ", cv='" + cv + '\'' +
                ", fullName='" + fullName + '\'' +
                ", publicName='" + publicName + '\'' +
                ", title='" + title + '\'' +
                ", department='" + department + '\'' +
                ", organization='" + organization + '\'' +
                ", address='" + address + '\'' +
                ", roleId=" + roleId +
                ", roleName='" + roleName + '\'' +
                '}';
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCv() {
        return cv;
    }

    public void setCv(String cv) {
        this.cv = cv;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPublicName() {
        return publicName;
    }

    public void setPublicName(String publicName) {
        this.publicName = publicName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
