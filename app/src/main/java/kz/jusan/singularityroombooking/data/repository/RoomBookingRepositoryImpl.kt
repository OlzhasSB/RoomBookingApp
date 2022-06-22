package kz.jusan.singularityroombooking.data.repository

import kz.jusan.singularityroombooking.data.remote.RoomBookingApi
import kz.jusan.singularityroombooking.data.remote.RoomBookingDto
import kz.jusan.singularityroombooking.domain.repository.RoomBookingRepository
import retrofit2.Response
import javax.inject.Inject

class RoomBookingRepositoryImpl @Inject constructor(
    private val api: RoomBookingApi
) : RoomBookingRepository {

    override suspend fun getRoomBookings(): Response<RoomBookingDto> {
        return api.getRoomBookings()
    }
}