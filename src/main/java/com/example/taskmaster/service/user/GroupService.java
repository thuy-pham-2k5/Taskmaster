package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Board;
import com.example.taskmaster.model.Group;

import java.security.SecureRandom;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class GroupService implements IGroupService {
    public static String newShortTitle = null;
    @Override
    public Group getGroupInfoById(int groupId) {
        String query = "select * from `groups` where group_id = ?";
        Group group = null;
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String short_title = resultSet.getString(2);
                String title = resultSet.getString(3);
                String linkWeb = resultSet.getString(4);
                String description = resultSet.getString(5);
                String visibility = resultSet.getString(6);
                group = new Group(groupId,short_title, title, linkWeb, description, visibility);
            }
            return group;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<Board> getStarredOrRecentBoards(int userId, String type) {
        List<Board> boardList = new ArrayList<>();
        String sql = "{call getRecentOrStarredBoardsByUserId (?, ?)}";

        try (Connection conn = ConnectDatabase.getConnection();
             CallableStatement callableStatement = conn.prepareCall(sql)) {
            callableStatement.setInt(1, userId);
            callableStatement.setString(2, type);
            ResultSet rs = callableStatement.executeQuery();
            while (rs.next()) {
                int boardId = rs.getInt("board_id");
                String title = rs.getString("board_title");
                String backgroundLink = rs.getString("image_link");
                int groupId = rs.getInt("group_id");
                boardList.add(new Board(boardId, title, backgroundLink, groupId));
            }
            return boardList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public Group getGroupInfoByTitleAndDescription(String title, String description) {
        String query = "select * from `groups` where title = ? and description = ?";
        Group group = null;
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, title);
            preparedStatement.setString(2, description);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int groupId = resultSet.getInt(1);
                String linkWeb = resultSet.getString(3);
                String visibility = resultSet.getString(5);
                group = new Group(groupId, title, linkWeb, description, visibility);
            }
            return group;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void inviteMember(int userId, int groupId, int roleId) {
        String query = "INSERT INTO user_group_relationships (`user_id`, `group_id`, `role_id`) VALUES (?, ?, ?)";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, groupId);
            preparedStatement.setInt(3, roleId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    @Override
    public List<Group> getTitleGroupByUserId(int user_id) {
        String query = "SELECT `groups`.group_id, `groups`.title FROM `groups` JOIN user_group_relationships ON `groups`.group_id = user_group_relationships.group_id JOIN users ON user_group_relationships.user_id = users.user_id WHERE users.user_id = ?";
        List<Group> titleGroupList = new ArrayList<>();
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, user_id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int groupId = resultSet.getInt("group_id");
                String title = resultSet.getString("title");
                Group group = new Group(groupId, title);
                titleGroupList.add(group);
            }
            return titleGroupList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void createGroup(Group group, int userId) {
        String query = "{call createNewGroup (?, ?, ?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, userId);
            callableStatement.setString(2, group.getTitle());
            callableStatement.setString(3, createNewShortTitle(group.getTitle()));
            callableStatement.setString(4, group.getDescription());
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String createNewShortTitle(String title) {
        String baseTitle = title.toLowerCase().replaceAll("[^a-z0-9]", "");
        StringBuilder result = new StringBuilder(baseTitle);
        SecureRandom random = new SecureRandom();

        try (Connection connection = ConnectDatabase.getConnection()) {
            List<String> similarShortTitleList = getSimilarShortTitle(connection, baseTitle);
            if (!similarShortTitleList.isEmpty()) {
                int maxAttempts = 100;
                int attempts = 0;
                while (checkExistShortTitle(result.toString(), similarShortTitleList) && attempts < maxAttempts) {
                    result.setLength(baseTitle.length());
                    result.append(random.nextInt(1000));
                    attempts++;

                    if (result.length() > 100) {
                        baseTitle = createNewShortTitle();
                        result = new StringBuilder(baseTitle);
                        attempts = 0;

                        similarShortTitleList = getSimilarShortTitle(connection, baseTitle);
                        if (!checkExistShortTitle(result.toString(), similarShortTitleList)) {
                            break;
                        }
                    }
                }
            }
            return result.toString();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean checkExistShortTitle(String newShortTitle, List<String> shortTitleList) {
        return shortTitleList.contains(newShortTitle);
    }

    public List<String> getSimilarShortTitle(Connection connection, String shortTitle) {
        String query = "SELECT short_title FROM `groups` WHERE short_title LIKE CONCAT('%', ?, '%');";
        List<String> shortTitleList = new ArrayList<>();

        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, shortTitle);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    shortTitleList.add(resultSet.getString(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return shortTitleList;
    }

    public String createNewShortTitle() {
        String allowCharacters = "abcdefghijklmnopqrstuvwxyz0123456789_";
        SecureRandom secureRandom = new SecureRandom();
        int lengthShortTitle = secureRandom.nextInt(5) + 14;
        StringBuilder shortTitle = new StringBuilder(lengthShortTitle);

        for (int i = 0; i < lengthShortTitle; i++) {
            shortTitle.append(allowCharacters.charAt(secureRandom.nextInt(allowCharacters.length())));
        }

        return shortTitle.toString();
    }


    @Override
    public void updateGroup(int groupId, Group group) {
        String query =" UPDATE `groups` SET short_title = ?, `title` = ?, `link_web` = ?, `description` = ? WHERE `group_id` = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, group.getShort_title());
            preparedStatement.setString(2, group.getTitle());
            preparedStatement.setString(3, group.getLinkWeb());
            preparedStatement.setString(4, group.getDescription());
            preparedStatement.setInt(5, groupId);
            System.out.println(group.getShort_title() + group.getTitle() +  group.getLinkWeb()+ group.getDescription());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void deleteGroup(int groupId) {
        String query = "delete from `groups` where group_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void deleteMemberFromGroup(int userId, int groupId) {
        String query = "delete from 'user_group_relationships' where user_id = ? and group_id = ?";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, groupId);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    // Lấy role của user trong từng nhóm
    public Map<Group, List<Board>> getBoardsInGroupWithRole(int userId, int roleType) throws SQLException {
        Map<Group, List<Board>> accessMap = new HashMap<>();
        String sql = "{CALL getBoardsInGroupWithRole(?, ?)}";

        try (Connection connection = ConnectDatabase.getConnection();
             CallableStatement callableStatement = connection.prepareCall(sql)) {
            callableStatement.setInt(1, userId);
            callableStatement.setInt(2, roleType);
            ResultSet resultSet = callableStatement.executeQuery();

            while (resultSet.next()) {
                int groupId = resultSet.getInt("group_id");
                String groupTitle = resultSet.getString("group_title");
                int boardId = resultSet.getInt("board_id");
                String boardTitle = resultSet.getString("board_title");
                String imageLink = resultSet.getString("image_link");

                // Tạo đối tượng Group
                Group group = new Group(groupId, groupTitle);

                // Nếu nhóm chưa có trong map, thêm vào
                accessMap.putIfAbsent(group, new ArrayList<>());

                // Thêm board vào danh sách của group
                accessMap.get(group).add(new Board(boardId, boardTitle, imageLink));
            }
        }
        return accessMap;
    }

    @Override
    public Group getGroupInfoByShortTitle(String shortTitle) {
        String query = "select * from `groups` where short_title = ?";
        Group group = null;
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            if (shortTitle != null) {
                preparedStatement.setString(1, shortTitle);
            } else {
                preparedStatement.setString(1, newShortTitle);
            }
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int groupId = resultSet.getInt(1);
                String title = resultSet.getString(3);
                String linkWeb = resultSet.getString(4);
                String description = resultSet.getString(5);
                String visibility = resultSet.getString(6);
                group = new Group(groupId, title, linkWeb, description, visibility);
            }
            return group;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}

