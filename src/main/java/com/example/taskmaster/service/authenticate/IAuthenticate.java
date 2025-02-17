package com.example.taskmaster.service.authenticate;

import com.example.taskmaster.model.User;

public interface IAuthenticate {
    void registerUser (User user);
    void signIn (String email, String password);
    void signOut ();
    void resetPassword (String email);
}
