package com.example.roombooking.Repositories;

import com.example.roombooking.Entities.Timetable;
import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Repository
public interface TimetableRepository extends CrudRepository<Timetable, Long> {
    @Query("SELECT * from TIMETABLE WHERE ROOM_ID = :roomID AND ((:timeto between TIMETO AND TIMEFROM) OR (:timefrom between TIMETO AND TIMEFROM))")
    Timetable clash(@Param("timefrom") Date timefrom,@Param("timeto") Date timeto,@Param("roomID") long roomID);
    @Query("SELECT * FROM TIMETABLE where ROOM_ID = :roomID order by TIMEFROM")
    List<Timetable> getTimeTables(long roomID);
    @Modifying
    @Query("INSERT INTO TIMETABLE(ID) VALUES(:id)")
    void create(@Param("id") long id);
    @Query("SELECT * FROM TIMETABLE where ID = :id")
    Timetable getTimeTable(@Param("id") long id);
    @Query("SELECT * FROM TIMETABLE where TIMETO < :time")
    List<Timetable> getTimetablesBefore(@Param("time") LocalDateTime localDateTime);
}
