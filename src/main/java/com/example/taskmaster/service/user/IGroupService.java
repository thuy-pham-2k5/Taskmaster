package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Group;
import com.example.taskmaster.model.User;

import java.util.List;

public interface IGroupService {
    User getUserInGroupByUserId (int userId, int groupId);
    Group getGroupInfoById (int groupId);
    void createGroup(Group group, int userId);
    void updateGroup (int groupId, Group group);
    void deleteGroup (int groupId);
    Group getGroupInfoByShortTitle(String shortTitle);
    boolean inviteMember (int userId, int groupId, int roleId);
    List<Group> getTitleGroupByUserId(int user_id);
    void deleteMemberFromGroup(int userId, int groupId);
}
