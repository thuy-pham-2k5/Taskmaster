package com.example.taskmaster.model;

public class Column {
    private int columnId;
    private String name;
    private int boardId, position;

    public Column(int columnId, String name, int boardId, int position) {
        this.columnId = columnId;
        this.name = name;
        this.boardId = boardId;
        this.position = position;
    }



    @Override
    public String toString() {
        return "Column{" +
                "listId=" + columnId +
                ", name='" + name + '\'' +
                ", boardId=" + boardId +
                ", position=" + position +
                '}';
    }

    public int getColumnId() {
        return columnId;
    }

    public void setColumnId(int columnId) {
        this.columnId = columnId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }
}
