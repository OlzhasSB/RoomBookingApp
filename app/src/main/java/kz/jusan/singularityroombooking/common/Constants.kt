package kz.jusan.singularityroombooking.common

import kz.jusan.singularityroombooking.R
import kz.jusan.singularityroombooking.domain.entities.Room

object Constants {

    val ROOMS_LIST = listOf(
        Room(R.drawable.ic_launcher_background, "Table Tennis (2nd Floor)", "tennis"),
        Room(R.drawable.ic_launcher_background, "Playstation (2nd Floor)", "playstation"),
        Room(R.drawable.ic_launcher_background, "Room 302 (Coworking)", "302"),
        Room(R.drawable.ic_launcher_background, "Room 303 (Conference Room)", "303"),
        Room(R.drawable.ic_launcher_background, "Room 304 (Mac Room)", "304"),
        Room(R.drawable.ic_launcher_background, "Room 404", "404")
    )

    const val BASE_URL = "http://164.92.196.125:8080/"

    const val ROOM_NAME = "ROOM_NAME"

    const val TOKEN = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJidG9rbXlyemEiLCJqdGkiOiIxIiwiZXhwIjoxNjU3MjM4NDAwfQ.hrJlt9j3YtWTkjhrEwXcvwSNsAFnzOrgRRdSgMEZBV800FwVl6u8uwQfw3ClYO2gYWpFSeuD__KcWVeyF4WQqw"

}