package com.example.taskmaster.model;

public class Board {
    private int boardId;
    private String title;
    private int backgroundId;
    private String backgroundLink;
    private int status, groupId;
    private String groupName;
    private boolean starredBoard;

    public Board(int boardId, String title, int backgroundId, String backgroundLink, int status, int groupId) {
        this.boardId = boardId;
        this.title = title;
        this.backgroundId = backgroundId;
        this.backgroundLink = backgroundLink;
        this.status = status;
        this.groupId = groupId;
    }

    public Board(int boardId, String title, String backgroundLink, int groupId, String groupName, boolean starredBoard) { // link bảng trong Gần đây, Đã đánh dấu sao, ...
        this.boardId = boardId;
        this.title = title;
        this.backgroundLink = backgroundLink;
        this.groupId = groupId;
        this.groupName = groupName;
        this.starredBoard = starredBoard;
    }

    public Board(int boardId, String title, int status) {
        this.boardId = boardId;
        this.title = title;
        this.status = status;
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

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public boolean isStarredBoard() {
        return starredBoard;
    }

    public void setStarredBoard(boolean starredBoard) {
        this.starredBoard = starredBoard;
    }
}
