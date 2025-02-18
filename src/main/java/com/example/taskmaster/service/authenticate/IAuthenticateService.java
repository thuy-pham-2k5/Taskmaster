package com.example.taskmaster.service.authenticate;

import com.example.taskmaster.model.User;

public interface IAuthenticateService {
    Boolean signUp (User user);
    void signIn (String email, String password);
    void logout ();
    void resetPassword (String email);
}
