package com.example.taskmaster.service.user;

import com.example.taskmaster.database.ConnectDatabase;
import com.example.taskmaster.model.Board;
import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.Task;
import com.example.taskmaster.model.User;

import java.security.SecureRandom;
import java.sql.*;
import java.util.*;

public class GroupService implements IGroupService {
    public static String newShortTitle = null;

    @Override
    public User getUserInGroupByUserId(int userId, int groupId) {
        String query = "select users.user_id, users.email, users.full_name, users.username, roles.name as role_name from users join user_group_relationships on users.user_id = user_group_relationships.user_id join roles on user_group_relationships.role_id = roles.role_id where user_group_relationships.group_id = ? and user_group_relationships.user_id = ? and roles.role_id != 5";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, groupId);
            preparedStatement.setInt(2, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String email = resultSet.getString(2);
                String fullName = resultSet.getString(3);
                String username = resultSet.getString(4);
                String roleName = resultSet.getString(5);
                if (roleName.equals("Admin Workspace"))
                    roleName = "Quản trị viên";
                else
                    roleName = "Thành viên";
                return new User(userId, email,fullName, username, roleName);
            } else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

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
    public void createGroup(Group group, int userId) {
        String query = "{call createNewGroup (?, ?, ?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, userId);
            callableStatement.setString(2, group.getTitle());
            newShortTitle = createNewShortTitle(group.getTitle());
            callableStatement.setString(3, newShortTitle);
            callableStatement.setString(4, group.getDescription());
            callableStatement.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
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

    @Override
    public boolean inviteMember(int userId, int groupId, int roleId) {
        String query = "{call inviteMemberInGroup(?, ?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, userId);
            callableStatement.setInt(2, groupId);
            callableStatement.setInt(3, roleId);
            return callableStatement.executeUpdate() > 0;
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
    public Map<Integer, List<Board>> getListBoardOfGroup(List<Group> groups) {
        Map<Integer, List<Board>> boardMap = new HashMap<>();
        if (groups.isEmpty()) return boardMap; // Tránh SQL lỗi nếu danh sách rỗng

        String placeholders = String.join(",", Collections.nCopies(groups.size(), "?"));
        String query = "select * from boards left join board_backgrounds bb on boards.background_id = bb.background_id where boards.group_id IN (" + placeholders + ")";

        try (Connection connection = ConnectDatabase.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            int index = 1;
            for (Group group : groups) {
                preparedStatement.setInt(index++, group.getGroupId());
            }
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    int groupId = resultSet.getInt("group_id");
                    boardMap.putIfAbsent(groupId, new ArrayList<>());
                    int boardId = resultSet.getInt(1);
                    String name = resultSet.getString(2);
                    int backgroundId = resultSet.getInt(3);
                    String backgroundLink = resultSet.getString(8);
                    String timestamp = resultSet.getString(4);
                    int status = resultSet.getInt(5);
                    boardMap.get(groupId).add(new Board(boardId, name, backgroundId, backgroundLink, timestamp, groupId, status));
                }
            }
            return boardMap;
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

    @Override
    public void deleteMemberInGroup(int userId, int groupId) {
        String query ="{CALL RemoveUserFromGroup(?, ?)}";
        try(Connection connection = ConnectDatabase.getConnection()){
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, userId);
            callableStatement.setInt(2, groupId);
            callableStatement.execute();
        }catch (Exception e){
            e.getMessage();
        }

    }

    @Override
    public List<Board> getGroupRecentOrStarred(int userId, String type) {
        List<Board> boards = new ArrayList<>();
        String query = "{call getRecentOrStarredBoardsByUserId (?, ?)}";
        try (Connection connection = ConnectDatabase.getConnection()) {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setString(2, type);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int groupId = resultSet.getInt(5);
                int boardId = resultSet.getInt(1);
                String boardTitle = resultSet.getString(2);
                int backgroundId = resultSet.getInt(3);
                String backgroundLink = resultSet.getString(4);
                boolean starred = resultSet.getBoolean(7);
                String timestamp = resultSet.getString(8);
                boards.add(new Board(boardId, boardTitle, backgroundId, backgroundLink, timestamp, 1, groupId, starred));
            }
            return boards;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
