package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Board;
import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;

import java.util.List;
import java.util.Map;

public interface IGroupService {
    User getUserInGroupByUserId (int userId, int groupId);
    Group getGroupInfoById (int groupId);
    void createGroup(Group group, int userId);
    void updateGroup (int groupId, Group group);
    void deleteGroup (int groupId);
    Group getGroupInfoByShortTitle(String shortTitle);
    boolean inviteMember (int userId, int groupId, int roleId);
    List<Group> getTitleGroupByUserId(int user_id);
    Map<Integer, List<Board>> getListBoardOfGroup (List<Group> groups);
    void deleteMemberInGroup(int userId, int groupId);
    List<Board> getGroupRecentOrStarred (int userId, String type);
}
