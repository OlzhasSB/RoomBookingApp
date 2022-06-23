package kz.jusan.singularityroombooking.domain.entities

import androidx.annotation.DrawableRes

data class Room(
    @DrawableRes val photo: Int,
    val displayName: String,
    val roomName: String
)
