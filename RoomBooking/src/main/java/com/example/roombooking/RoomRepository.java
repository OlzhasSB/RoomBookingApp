package com.example.roombooking;


import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomRepository extends CrudRepository<Room, Long> {
    @Query("SELECT * FROM ROOM where NAME = :name")
    Room getRoom(@Param("name")String name);
}
