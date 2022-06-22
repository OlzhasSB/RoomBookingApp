package com.example.roombooking;

import lombok.Data;

import java.util.Date;

@Data
public class AddRequest {
    private String person;
    private Date timefrom;
    private Date timeto;
    private String contact;
}
