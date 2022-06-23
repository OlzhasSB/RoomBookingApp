package kz.jusan.singularityroombooking.data.remote

import com.google.gson.annotations.SerializedName

data class AddRoomBookingDto(
    @SerializedName("person")
    val personName: String,
    @SerializedName("timefrom")
    val fromDate: String,
    @SerializedName("timeto")
    val toDate: String,
    @SerializedName("contact")
    val contactInfo: String
)