package com.example.roombooking;

import com.example.roombooking.Controllers.AddRequest;
import com.example.roombooking.Entities.Room;
import com.example.roombooking.Entities.Timetable;
import com.example.roombooking.Repositories.RoomRepository;
import com.example.roombooking.Repositories.TimetableRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@AllArgsConstructor
public class DataService {
    private RoomRepository roomRepository;
    private TimetableRepository timetableRepository;
    private static long id = 0;
    @Transactional
    public List<Timetable> getTimeTables(String name) {
        return timetableRepository.getTimeTables(getID(name));
    }
    @Transactional
    public boolean clash(AddRequest request, String name) {
        Timetable t = timetableRepository.clash(request.getTimefrom(), request.getTimeto(), getID(name));
        return t != null;
    }
    @Transactional
    public void pushTimetable(AddRequest request, String name, String person) {
        Timetable timetable = new Timetable(id, person, request.getTimefrom(), request.getTimeto(), request.getContact(), getID(name));
        timetableRepository.create(id);
        timetableRepository.save(timetable);
        id++;
    }

    private long getID(String name){
        return getRoom(name).getId();
    }
    @Transactional
    public Room getRoom(String name) {
        return roomRepository.getRoom(name);
    }
    @Transactional
    public Timetable getTimeTable(long id) {
        return timetableRepository.getTimeTable(id);
    }
    @Transactional
    public void delete(Timetable timetable) {
        timetableRepository.delete(timetable);
    }
    @Transactional
    public void clear(List<Timetable> timeTable) {
        timetableRepository.deleteAll(timeTable);
    }
    @Transactional
    public List<Timetable> getTimetablesBefore(LocalDateTime localDateTime) {
        return timetableRepository.getTimetablesBefore(localDateTime);
    }
}
