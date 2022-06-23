package kz.jusan.singularityroombooking.domain.entities

import java.util.*

data class RoomBooking(
    val fromDate: String,
    val toDate: String,
    val personName: String,
    val purpose: String,
    val contactInfo: String
)
