package kz.jusan.singularityroombooking.domain.entities

import java.util.*

data class RoomBooking(
    val fromDate: Date,
    val toDate: Date,
    val personName: String,
    val purpose: String,
    val contactInfo: String
)
