package kz.jusan.singularityroombooking.domain.repository

import kz.jusan.singularityroombooking.data.remote.RoomBookingDto
import retrofit2.Response

interface RoomBookingRepository {

    suspend fun getRoomBookings(name: String) : Response<List<RoomBookingDto>>

}