package kz.jusan.singularityroombooking.presentation

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.activity.viewModels
import androidx.recyclerview.widget.LinearLayoutManager
import dagger.hilt.android.AndroidEntryPoint
import kz.jusan.singularityroombooking.common.Constants.ROOMS_LIST
import kz.jusan.singularityroombooking.common.Constants.ROOM_NAME
import kz.jusan.singularityroombooking.databinding.ActivityMainBinding
import kz.jusan.singularityroombooking.presentation.adapters.RoomsAdapter

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var roomsAdapter: RoomsAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setupRoomsRecyclerView()

        roomsAdapter.setRoomClickListener {
            val intent = Intent(this, RoomBookingActivity::class.java)
            intent.putExtra(ROOM_NAME, it.roomName)
            startActivity(intent)
        }
    }

    private fun setupRoomsRecyclerView() {
        roomsAdapter = RoomsAdapter()
        roomsAdapter.rooms = ROOMS_LIST

        binding.rvRooms.apply {
            adapter = roomsAdapter
            layoutManager = LinearLayoutManager(this@MainActivity)
        }
    }

}