package com.example.roombooking.Controllers;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@org.springframework.web.bind.annotation.ControllerAdvice
public class ControllerAdvice {
    @ResponseBody
    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus()
    String error(RuntimeException e){
        return e.getMessage();
    }
}
