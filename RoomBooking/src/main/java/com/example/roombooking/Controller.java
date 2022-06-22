package com.example.roombooking;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/rooms")
@AllArgsConstructor
public class Controller {
    private DataService dataService;

    @GetMapping("/{name}")
    public List<Timetable> getTimeTable(@PathVariable String name){
        return dataService.getTimeTable(name);
    }

    @PostMapping("/{name}")
    public void addTimeTable(@PathVariable String name, @RequestBody AddRequest request){
        if(dataService.getRoom(name) == null || dataService.clash(request, name) || request.getTimeto().before(request.getTimefrom())) {
            throw new RuntimeException("FAIL");
        }
        dataService.pushTimetable(request, name);
    }
}
