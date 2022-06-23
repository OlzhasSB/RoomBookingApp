package kz.jusan.singularityroombooking.domain.repository

import kz.jusan.singularityroombooking.data.remote.AddRoomBookingDto
import kz.jusan.singularityroombooking.data.remote.RoomBookingDto
import retrofit2.Call
import retrofit2.Response
import retrofit2.http.Field
import retrofit2.http.Path

interface RoomBookingRepository {

    suspend fun getRoomBookings(name: String) : Response<List<RoomBookingDto>>

    suspend fun addRoomBooking(
        name: String,
        body: AddRoomBookingDto
    )
}