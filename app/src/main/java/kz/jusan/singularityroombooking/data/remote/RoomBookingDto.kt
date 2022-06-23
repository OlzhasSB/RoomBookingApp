package kz.jusan.singularityroombooking.data.remote

import com.google.gson.annotations.SerializedName
import kz.jusan.singularityroombooking.domain.entities.RoomBooking

data class RoomBookingDto(
    @SerializedName("room_ID")
    val roomId: String,
    @SerializedName("timefrom")
    val fromDate: String,
    @SerializedName("timeto")
    val toDate: String,
    @SerializedName("person")
    val personName: String,
    @SerializedName("contact")
    val contactInfo: String
)

fun RoomBookingDto.toRoomBooking(): RoomBooking {
    return RoomBooking(
        fromDate = fromDate,
        toDate = toDate,
        personName = personName,
        contactInfo = contactInfo
    )
}