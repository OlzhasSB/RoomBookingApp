package kz.jusan.singularityroombooking.common

import kz.jusan.singularityroombooking.R
import kz.jusan.singularityroombooking.domain.entities.Room

object Constants {

    val ROOMS_LIST = listOf(
        Room(R.drawable.table_tennis, "Table Tennis (2nd Floor)", "tennis"),
        Room(R.drawable.ps5, "Playstation (2nd Floor)", "playstation"),
        Room(R.drawable.coworking, "Room 302 (Coworking)", "302"),
        Room(R.drawable.conference_room, "Room 303 (Conference Room)", "303"),
        Room(R.drawable.mac_room, "Room 304 (Mac Room)", "304"),
        Room(R.drawable.fouth_floor, "Room 404", "404")
    )

    const val BASE_URL = "http://164.92.196.125:8080/"

    const val ROOM_NAME = "ROOM_NAME"

}