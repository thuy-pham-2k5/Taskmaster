package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Group;

import java.util.List;

public interface IGroupService {
    Group getGroupInfoById (int groupId);
    void createGroup(Group group, int userId);
    void updateGroup (int groupId, Group group);
    void deleteGroup (int groupId);

    void leaveMember(int userId, int groupId, int roleId);

    Group getGroupInfoByShortTitle(String shortTitle);
    void inviteMember (int userId, int groupId, int roleId);
    List<Group> getTitleGroupByUserId(int user_id);
    void deleteMemberFromGroup(int userId, int groupId);
}
