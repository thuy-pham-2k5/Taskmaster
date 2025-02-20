package com.example.taskmaster.service.user;

public interface IUserService {
    int getRoleUserInGroup (int userId, int groupId);
    int getGroupByUserId (int userId);

}
