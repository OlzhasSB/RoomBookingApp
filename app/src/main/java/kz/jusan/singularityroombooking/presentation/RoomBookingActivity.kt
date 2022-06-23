package kz.jusan.singularityroombooking.presentation

import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import dagger.hilt.android.AndroidEntryPoint
import kz.jusan.singularityroombooking.common.Constants.ROOM_NAME
import kz.jusan.singularityroombooking.databinding.ActivityRoomBookingBinding
import kz.jusan.singularityroombooking.presentation.adapters.RoomBookingsAdapter

@AndroidEntryPoint
class RoomBookingActivity : AppCompatActivity() {

    private lateinit var binding: ActivityRoomBookingBinding
    private lateinit var roomsBookingsAdapter: RoomBookingsAdapter
    private val roomBookingViewModel: RoomBookingViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityRoomBookingBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val roomName = intent.getStringExtra(ROOM_NAME)
        roomBookingViewModel.setRoomName(roomName!!)

        setupRoomBookingsRecyclerView()

        roomBookingViewModel.roomBookings.observe(this) { roomBookings ->
            roomsBookingsAdapter.roomBookings = roomBookings
        }

    }

    private fun setupRoomBookingsRecyclerView() {
        roomsBookingsAdapter = RoomBookingsAdapter()
        binding.rvRoomBookings.apply {
            adapter = roomsBookingsAdapter
            layoutManager = LinearLayoutManager(this@RoomBookingActivity)
        }
    }

}