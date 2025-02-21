package com.example.taskmaster.model;

public class Group {
    private int groupId;
    private String title, linkWeb, description, visibility;

    public Group(int groupId, String title, String linkWeb, String description, String visibility) {
        this.groupId = groupId;
        this.title = title;
        this.linkWeb = linkWeb;
        this.description = description;
        this.visibility = visibility;
    }

    public Group(String title, String link_web, String description, String visibility) {
        this.title = title;
        this.linkWeb = link_web;
        this.description = description;
        this.visibility = visibility;
    }

    public Group(String title, String description) {
        this.title = title;
        this.description = description;
    }
    @Override
    public String toString() {
        return "Group{" +
                "groupId=" + groupId +
                ", title='" + title + '\'' +
                ", linkWeb='" + linkWeb + '\'' +
                ", description='" + description + '\'' +
                ", visibility='" + visibility + '\'' +
                '}';
    }
    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLinkWeb() {
        return linkWeb;
    }

    public void setLinkWeb(String linkWeb) {
        this.linkWeb = linkWeb;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getVisibility() {
        return visibility;
    }

    public void setVisibility(String visibility) {
        this.visibility = visibility;
    }
}