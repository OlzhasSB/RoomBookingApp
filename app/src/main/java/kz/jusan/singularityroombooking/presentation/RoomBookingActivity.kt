package kz.jusan.singularityroombooking.presentation

import android.os.Bundle
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import dagger.hilt.android.AndroidEntryPoint
import kz.jusan.singularityroombooking.common.Constants.ROOM_NAME
import kz.jusan.singularityroombooking.databinding.ActivityRoomBookingBinding
import kz.jusan.singularityroombooking.presentation.adapters.RoomBookingsAdapter
import kz.jusan.singularityroombooking.presentation.dialogs.AddBookingBottomSheetDialog
import kz.jusan.singularityroombooking.presentation.viewmodels.RoomBookingViewModel
import javax.inject.Inject

@AndroidEntryPoint
class RoomBookingActivity : AppCompatActivity() {

    private lateinit var binding: ActivityRoomBookingBinding
    private lateinit var roomsBookingsAdapter: RoomBookingsAdapter
    private val roomBookingViewModel: RoomBookingViewModel by viewModels()

    @Inject
    lateinit var addBookingBottomSheetDialog: AddBookingBottomSheetDialog

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityRoomBookingBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setupRoomBookingsRecyclerView()

        val roomName = intent.getStringExtra(ROOM_NAME)
        roomBookingViewModel.loadRoomBookings(roomName ?: "tennis")

        roomBookingViewModel.roomBookings.observe(this) { roomBookings ->
            roomsBookingsAdapter.roomBookings = roomBookings
        }

        val bundle = Bundle()
        bundle.putString("roomName", roomName)
        addBookingBottomSheetDialog.arguments = bundle

        binding.fabAdd.setOnClickListener {
            addBookingBottomSheetDialog.show(supportFragmentManager, null)
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