package com.example.taskmaster.service.authenticate;

import com.example.taskmaster.model.User;

public interface IAuthenticateService {
    void signUp (User user);
    void signIn (String email, String password);
    void logOut ();
    void resetPassword (String email);
}
