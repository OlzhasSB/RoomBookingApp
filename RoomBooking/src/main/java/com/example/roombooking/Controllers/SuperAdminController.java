package com.example.roombooking.Controllers;

import com.example.roombooking.Users.Controllers.RegistrationRequest;
import com.example.roombooking.Users.Details.User;
import com.example.roombooking.Users.Details.UserService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/superadmin")
@SecurityRequirement(name = "basicauth")
@AllArgsConstructor
public class SuperAdminController {
    private UserService userService;

    @DeleteMapping("/{name}")
    public void deleteUser(@PathVariable String name){
        User user = userService.findByLogin(name);
        if (user == null) throw new RuntimeException("FAIL");
        userService.delete(user);
    }
    @PostMapping("/create")
    public void createAdmin (@RequestBody @Valid RegistrationRequest registrationRequest){
        if(userService.findByLogin(registrationRequest.getLogin()) != null) throw new RuntimeException("User is already exists");
        User user = new User();
        user.setPassword(registrationRequest.getPassword());
        user.setLogin(registrationRequest.getLogin());
        userService.saveAdmin(user);
    }
}
