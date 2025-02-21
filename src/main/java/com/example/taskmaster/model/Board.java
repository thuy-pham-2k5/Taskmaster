package com.example.taskmaster.model;

public class Board {
    private int boardId;
    private String title;
    private String backgroundId;
    private Boolean status;
    private int groupId;

    public Board(int boardId, String title, String backgroundId, Boolean status, int groupId) {
        this.boardId = boardId;
        this.title = title;
        this.backgroundId = backgroundId;
        this.status = status;
        this.groupId = groupId;
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

    public String getBackgroundId() {
        return backgroundId;
    }

    public void setBackgroundId(String backgroundId) {
        this.backgroundId = backgroundId;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    @Override
    public String toString() {
        return "Board{" +
                "boardId=" + boardId +
                ", title='" + title + '\'' +
                ", backgroundId='" + backgroundId + '\'' +
                ", status=" + status +
                ", groupId=" + groupId +
                '}';
    }
}