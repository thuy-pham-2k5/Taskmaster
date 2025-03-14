package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Board;
import com.example.taskmaster.model.Group;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface IGroupService {
    Group getGroupInfoById (int groupId);
    void createGroup(Group group, int userId);
    void updateGroup (int groupId, Group group);
    void deleteGroup (int groupId);

    List<Board> getStarredOrRecentBoards(int userId, String type);

    Group getGroupInfoByTitleAndDescription (String title, String description);
    void inviteMember (int userId, int groupId, int roleId);
    List<Group> getTitleGroupByUserId(int user_id);
    void deleteMemberFromGroup(int userId, int groupId);


    public Map<Group, List<Board>> getBoardsInGroupWithRole(int userId, int roleType) throws SQLException;
}
