package kz.jusan.singularityroombooking.data.remote

import com.google.gson.annotations.SerializedName

data class RoomBookingDto(
    @SerializedName("from_date")
    val fromDate: String,
    @SerializedName("to_date")
    val toDate: String,
    @SerializedName("person_name")
    val personName: String,
    @SerializedName("purpose")
    val purpose: String,
    @SerializedName("contact_info")
    val contactInfo: String
)
