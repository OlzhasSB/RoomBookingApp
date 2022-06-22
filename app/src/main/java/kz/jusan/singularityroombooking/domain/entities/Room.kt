package kz.jusan.singularityroombooking.domain.entities

import androidx.annotation.DrawableRes

data class Room(
    @DrawableRes val photo: Int,
    val roomName: String
)
