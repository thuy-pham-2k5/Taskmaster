package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Board;
import com.example.taskmaster.model.Task;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import static java.time.LocalTime.now;

public class BoardService implements IBoardService {

    @Override
    public List<Board> getAllBoardInGroupJoined(int groupId, int userId) {
        String query = " select b.board_id, b.title, bb.image_link, ubr.timestamp, b.status, ubr.starred from boards b left join board_backgrounds bb on b.background_id = bb.background_id left join user_board_relationships ubr on ubr.board_id = b.board_id where b.group_id = ? and ubr.user_id = ? and b.status = 1 order by b.title";
        List<Board> boards = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            preparedStatement.setInt(2, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int boardId = resultSet.getInt(1);
                String title = resultSet.getString(2);
                String imageLink = resultSet.getString(3);
                String timestamp = resultSet.getString(4);
                int status = resultSet.getInt(5);
                boolean starred = resultSet.getBoolean(6);
                boards.add(new Board(boardId, title, imageLink, timestamp, status, starred));
            }
            return boards;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> getAllBoardInGroup(int groupId, String sortType) {
        String query = "{call sortTypeByOption (?, ?)}";
        List<Board> boards = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, groupId);
            callableStatement.setString(2, sortType);
            ResultSet resultSet = callableStatement.executeQuery();
            return getBoards(groupId, boards, resultSet);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private List<Board> getBoards(int groupId, List<Board> boards, ResultSet resultSet) throws SQLException {
        while (resultSet.next()) {
            int boardId = resultSet.getInt(1);
            String title = resultSet.getString(2);
            int backgroundId = resultSet.getInt(3);
            String backgroundLink = resultSet.getString(8);
            int status = resultSet.getInt(5);
            boards.add(new Board(boardId, title, backgroundId, backgroundLink, status, groupId));
        }
        return boards;
    }

    @Override
    public Board getBoardById(int boardId) {
        Board board = null;
        String query = "select * from boards where board_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, boardId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String title = resultSet.getString(2);
                int status = resultSet.getInt(5);
                board = new Board(boardId, title, status);
            }
            return board;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void saveTimestampToBoard(int userId, int boardId) {
        String query = "{call setTimestampToBoard (?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, userId);
            callableStatement.setInt(2, boardId);
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void changeStarredBoard(int userId, int boardId, boolean starred) {
        String query = "UPDATE user_board_relationships set starred = ? WHERE (user_id = ? and board_id = ?);";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setBoolean(1, starred);
            preparedStatement.setInt(2, userId);
            preparedStatement.setInt(3, boardId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> sortBoardByTime(int groupId, boolean sortType) {
        String query = "{call GetBoardsByTime(?, ?)}";
        List<Board> boards = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, groupId);
            callableStatement.setString(2, sortType ? "1" : "0");
            ResultSet resultSet = callableStatement.executeQuery();
            return getBoards(groupId, boards, resultSet);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> searchBoardsByName(int groupId, String keyword) {
        String query = "select * from boards left join board_backgrounds on boards.background_id = board_backgrounds.background_id where boards.group_id =  ? and boards.status = 1 and boards.title like concat('%', ? , '%');";
        List<Board> boards = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            preparedStatement.setString(2, keyword);
            ResultSet resultSet = preparedStatement.executeQuery();
            return getBoards(groupId, boards, resultSet);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> getAllBoardClosedInGroup(int groupId) {
        String query = "select b.board_id, b.title, b.background_id, bb.image_link, b.group_id, g.title\n" +
                "from boards b\n" +
                "join board_backgrounds bb on b.background_id = bb.background_id\n" +
                "join user_board_relationships ubr on ubr.board_id = b.board_id\n" +
                "join `groups` g on g.group_id = b.group_id\n" +
                "where b.group_id = ? and b.status = 0 group by b.board_id order by max(ubr.timestamp) desc;";
        List<Board> boards = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int boardId = resultSet.getInt(1);
                String title = resultSet.getString(2);
                int backgroundId = resultSet.getInt(3);
                String backgroundLink = resultSet.getString(4);
                String titleGroup = resultSet.getString(6);
                boards.add(new Board(boardId, title, backgroundId, backgroundLink, groupId, titleGroup));
            }
            return boards;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void createBoard(int userId, String boardTitle, int groupId, String backgroundLink) {
        String query = "{call createNewBoard (?, ?, ?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, userId);
            callableStatement.setString(2, boardTitle);
            callableStatement.setInt(4, groupId);
            callableStatement.setString(3, backgroundLink);
            callableStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean deleteBoard(int boardId) {
        String query = "{call deleteBoardFromGroup (?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, boardId);
            return callableStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void changeStatusBoard (int boardId, boolean status){
        String query = "UPDATE boards SET status = ? WHERE board_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setBoolean(1, status);
            preparedStatement.setInt(2, boardId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void leaveBoardById(int boardId, int userId) {
        String query = "{call leaveTheBoard(?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, boardId);
            callableStatement.setInt(2, userId);
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int checkBoardBackground(String backgroundLink) {
        String query = "{call GetOrInsertBackground (?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setString(1, backgroundLink);
            ResultSet resultSet = callableStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
            return 1;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void saveDescriptionInTask(int taskId, String description) {
        String query = "update tasks set description = ? where task_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, description);
            preparedStatement.setInt(2, taskId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void editTitleBoard(int boardId, String title) {
        String query = "UPDATE `taskmaster`.`boards` SET `title` = ? WHERE (`board_id` = ?)";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, title);
            preparedStatement.setInt(2, boardId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

