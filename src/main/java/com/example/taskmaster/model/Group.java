package com.example.taskmaster.model;

public class Group {
    private int group_id;
    private String title;
    private String link_web;
    private String description;
    private String visibility;


    public Group() {
    }

    public Group(int group_id, String title, String link_web, String description, String visibility) {
        this.group_id = group_id;
        this.title = title;
        this.link_web = link_web;
        this.description = description;
        this.visibility = visibility;
    }


    public Group(String title, String link_web, String description, String visibility) {
        this.title = title;
        this.link_web = link_web;
        this.description = description;
        this.visibility = visibility;
    }

    public Group(String title, String description) {
        this.title = title;
        this.description = description;
    }

    public int getGroup_id() {
        return group_id;
    }

    public void setGroup_id(int group_id) {
        this.group_id = group_id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLink_web() {
        return link_web;
    }

    public void setLink_web(String link_web) {
        this.link_web = link_web;
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
