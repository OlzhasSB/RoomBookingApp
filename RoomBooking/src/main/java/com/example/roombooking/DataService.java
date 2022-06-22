package com.example.roombooking;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class DataService {
    private RoomRepository roomRepository;
    private TimetableRepository timetableRepository;
    private static long id = 0;
    @Transactional
    public List<Timetable> getTimeTable(String name) {
        return timetableRepository.getTimeTable(getID(name));
    }
    @Transactional
    public boolean clash(AddRequest request, String name) {
        Timetable t = timetableRepository.clash(request.getTimefrom(), request.getTimeto(), getID(name));
        return t != null;
    }
    @Transactional
    public void pushTimetable(AddRequest request, String name) {
        Timetable timetable = new Timetable(id, request.getPerson(), request.getTimefrom(), request.getTimeto(), request.getContact(), getID(name));
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
}
