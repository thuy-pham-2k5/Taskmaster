package com.example.taskmaster.service.user;

import com.example.taskmaster.model.User;

import java.util.List;

public interface IUserService {
    int getRoleUserInGroup (int userId, int groupId);
    List<User> getAllMemberGroup (int groupId);
    List<User> getAllGuestGroup (int groupId);
    List<User> getAllRequestToJoinGroup (int groupId);
}
