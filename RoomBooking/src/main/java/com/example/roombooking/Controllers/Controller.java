package com.example.roombooking.Controllers;

import com.example.roombooking.DataService;
import com.example.roombooking.Entities.Timetable;
import com.example.roombooking.Users.Jwt.JwtProvider;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.webjars.NotFoundException;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/rooms")
@SecurityRequirement(name = "basicauth")
@AllArgsConstructor
public class Controller {
    private DataService dataService;
    private JwtProvider jwtProvider;

    @GetMapping("/{name}")
    public List<Timetable> getTimeTable(@PathVariable String name){
        if(dataService.getRoom(name) == null) throw new NotFoundException("There is no such room.");
        return dataService.getTimeTables(name);
    }

    @PostMapping("/{name}")
    public void addTimeTable(@RequestHeader("Authorization") String req, @PathVariable String name, @RequestBody AddRequest request){
        if(dataService.getRoom(name) == null){
            throw new NotFoundException("There is no such room.");
        }
        if(dataService.clash(request, name)) {
            throw new RuntimeException("Your timetable clashes with other timetable");
        }
        if(request.getTimeto().before(request.getTimefrom())) {
            throw new IllegalArgumentException("Incorrect data");
        }
        String person = jwtProvider.getLoginFromToken(req.substring(7));
        dataService.pushTimetable(request, name, person);
    }
    @DeleteMapping("/clear")
    public void clear(){
        LocalDateTime localDateTime = LocalDateTime.now();
        dataService.clear(getTimetablesBefore(localDateTime));
    }

    private List<Timetable> getTimetablesBefore(LocalDateTime localDateTime) {
        return dataService.getTimetablesBefore(localDateTime);
    }
    @DeleteMapping("/{id}")
    private void delete(@RequestHeader("Authorization") String req, @PathVariable long id){
        Timetable timetable = dataService.getTimeTable(id);
        String person = jwtProvider.getLoginFromToken(req.substring(7));
        if(timetable == null){
            throw new NotFoundException("There is no such timetable.");
        }
        if(!timetable.getPERSON().equals(person)) throw new RuntimeException("You don't have access to this timetable");
        dataService.delete(timetable);
    }
}
