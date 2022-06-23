package kz.jusan.singularityroombooking.data.repository

import kz.jusan.singularityroombooking.data.remote.AddRoomBookingDto
import kz.jusan.singularityroombooking.data.remote.RoomBookingApi
import kz.jusan.singularityroombooking.data.remote.RoomBookingDto
import kz.jusan.singularityroombooking.domain.repository.RoomBookingRepository
import retrofit2.Call
import retrofit2.Response
import javax.inject.Inject

class RoomBookingRepositoryImpl @Inject constructor(
    private val api: RoomBookingApi
) : RoomBookingRepository {

    override suspend fun getRoomBookings(name: String): Response<List<RoomBookingDto>> {
        return api.getRoomBookings(name)
    }

    override suspend fun addRoomBooking(
        name: String,
        body: AddRoomBookingDto
    ) {
        return api.addRoomBooking(
            name,
            body
        )
    }
}