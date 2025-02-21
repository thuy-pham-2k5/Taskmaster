package com.example.taskmaster.service.authenticate;

import com.example.taskmaster.model.Group;

public interface GroupServiceInterface {
    void createGroup(Group group, int userId);

}
