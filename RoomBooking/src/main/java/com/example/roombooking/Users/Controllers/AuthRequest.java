package com.example.roombooking.Users.Controllers;


import lombok.Data;

@Data
public class AuthRequest {
    private String login;
    private String password;
    public String toString(){
        return login + ":" + password;
    }
}