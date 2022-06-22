package kz.jusan.singularityroombooking.presentation

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import kz.jusan.singularityroombooking.common.Constants.ROOMS_LIST
import kz.jusan.singularityroombooking.databinding.ActivityMainBinding
import kz.jusan.singularityroombooking.presentation.adapters.RoomsAdapter

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private lateinit var roomsAdapter: RoomsAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setupRecyclerView()

        roomsAdapter.setRoomClickListener {

        }
    }

    private fun setupRecyclerView() {
        roomsAdapter = RoomsAdapter()
        roomsAdapter.rooms = ROOMS_LIST

        binding.rvRooms.apply {
            adapter = roomsAdapter
            layoutManager = LinearLayoutManager(this@MainActivity)
        }
    }

}