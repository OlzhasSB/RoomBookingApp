package com.example.roombooking.Users.Details;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Getter
@Setter
@Table(name = "USERS")
@Data
@Builder
@AllArgsConstructor
public class User {
    private @Id Integer ID;
    private String login;
    private String password;
    private String role;

    public User() {

    }
}
