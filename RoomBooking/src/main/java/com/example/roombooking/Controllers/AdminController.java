package com.example.roombooking.Controllers;

import com.example.roombooking.DataService;
import com.example.roombooking.Entities.Timetable;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.webjars.NotFoundException;

@RestController
@RequestMapping("/admin")
@SecurityRequirement(name = "basicauth")
@AllArgsConstructor
public class AdminController {
    private DataService dataService;
    @DeleteMapping("/{id}")
    public void deleteTimeTable(@PathVariable long id) {
        Timetable timetable = dataService.getTimeTable(id);
        if (timetable == null) throw new NotFoundException("There is no such timetable.");
        dataService.delete(timetable);
    }
}
