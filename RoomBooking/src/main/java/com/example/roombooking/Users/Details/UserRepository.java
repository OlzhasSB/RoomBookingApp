package com.example.roombooking.Users.Details;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends CrudRepository<User, Integer> {
    @Query("SELECT * FROM USERS WHERE LOGIN = :1")
    User findByLogin(@Param("1") String login);
}
