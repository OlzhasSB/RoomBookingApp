package com.example.roombooking;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

import java.util.Date;
@Table(name = "TIMETABLE")
@Getter
@Setter
@Data
@AllArgsConstructor
public class Timetable {
    private @Id Long ID;
    private String PERSON;
    private Date TIMEFROM;
    private Date TIMETO;
    private String CONTACT;
    private Long ROOM_ID;
}
