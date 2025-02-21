package com.example.taskmaster.model;

public class Board {
    private int boardId;
    private String title;
    private int backgroundId;
    private String backgroundLink;
    private int status, groupId;

    public Board(int boardId, String title, int backgroundId, String backgroundLink, int status, int groupId) {
        this.boardId = boardId;
        this.title = title;
        this.backgroundId = backgroundId;
        this.backgroundLink = backgroundLink;
        this.status = status;
        this.groupId = groupId;
    }

    public Board(String title, int backgroundId, int groupId) {
        this.title = title;
        this.backgroundId = backgroundId;
        this.groupId = groupId;
    }

    @Override
    public String toString() {
        return "Board{" +
                "boardId=" + boardId +
                ", title='" + title + '\'' +
                ", backgroundId='" + backgroundId + '\'' +
                ", backgroundLink='" + backgroundLink + '\'' +
                ", status=" + status +
                ", groupId=" + groupId +
                '}';
    }

    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getBackgroundId() {
        return backgroundId;
    }

    public void setBackgroundId(int backgroundId) {
        this.backgroundId = backgroundId;
    }

    public String getBackgroundLink() {
        return backgroundLink;
    }

    public void setBackgroundLink(String backgroundLink) {
        this.backgroundLink = backgroundLink;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }
}
