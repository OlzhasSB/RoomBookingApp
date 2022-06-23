package kz.jusan.singularityroombooking.data.remote

import retrofit2.Call
import retrofit2.Response
import retrofit2.http.*

interface RoomBookingApi {

    @GET("rooms/{name}")
    suspend fun getRoomBookings(
        @Path("name") name: String
    ) : Response<List<RoomBookingDto>>

    @POST("rooms/{name}")
    suspend fun addRoomBooking(
        @Path("name") name: String,
        @Body body: AddRoomBookingDto
    )

}