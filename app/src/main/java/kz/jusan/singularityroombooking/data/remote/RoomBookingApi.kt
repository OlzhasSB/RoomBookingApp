package kz.jusan.singularityroombooking.data.remote

import retrofit2.Response
import retrofit2.http.GET

interface RoomBookingApi {

    @GET("/timetable")
    suspend fun getRoomBookings() : Response<RoomBookingDto>

}