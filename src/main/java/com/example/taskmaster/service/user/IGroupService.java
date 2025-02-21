package com.example.taskmaster.service.user;

import com.example.taskmaster.model.Group;

public interface IGroupService {
    Group getGroupInfoById (int groupId);
    void createGroup(Group group, int userId);
    void updateGroup (int groupId, Group group);
    Group getGroupInfoByTitleAndDescription (String title, String description);
    void inviteMember (int userId, int groupId, int roleId);
}
