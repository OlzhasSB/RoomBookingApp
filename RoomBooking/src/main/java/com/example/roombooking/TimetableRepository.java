package com.example.roombooking;

import org.springframework.data.jdbc.repository.query.Modifying;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface TimetableRepository extends CrudRepository<Timetable, Long> {
    @Query("SELECT * from TIMETABLE WHERE ROOM_ID = :roomID AND ((:timeto between TIMETO AND TIMEFROM) OR (:timefrom between TIMETO AND TIMEFROM))")
    Timetable clash(@Param("timefrom") Date timefrom,@Param("timeto") Date timeto,@Param("roomID") long roomID);
    @Query("SELECT * FROM TIMETABLE where ROOM_ID = :roomID order by TIMEFROM")
    List<Timetable> getTimeTable(long roomID);
    @Modifying
    @Query("INSERT INTO TIMETABLE(ID) VALUES(:id)")
    void create(@Param("id") long id);
}
