package com.example.roombooking;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;


@Table(name = "ROOM")
@Getter
@Setter
@Data
public class Room {
    private @Id long id;
    private String name;
}
