package com.example.roombooking.Controllers;

import lombok.Data;

import java.util.Date;

@Data
public class AddRequest {
    private Date timefrom;
    private Date timeto;
    private String contact;
}
