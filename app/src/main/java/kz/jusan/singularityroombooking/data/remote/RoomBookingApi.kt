package kz.jusan.singularityroombooking.data.remote

import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Path

interface RoomBookingApi {

    @GET("rooms/{name}")
    suspend fun getRoomBookings(
        @Path("name") name: String
    ) : Response<List<RoomBookingDto>>

}