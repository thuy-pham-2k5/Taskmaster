package com.example.taskmaster.service.authenticate;

import com.example.taskmaster.model.User;

public interface IAuthenticateService {
    boolean signUp (User user);
    boolean signIn (String email, String password);
    void resetPassword (String email, String password);
}
