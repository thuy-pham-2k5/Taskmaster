package com.example.taskmaster.service.permission;

import com.example.taskmaster.model.Permission;

import java.util.List;

public interface IPermissionService {
    List<Permission> getAllMyPermissionInGroup (int userId, int groupId);
    List<Permission> getAllMyPermissionInBoard (int userId, int boardId);
}
