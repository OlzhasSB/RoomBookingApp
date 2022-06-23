package kz.jusan.singularityroombooking.presentation.viewmodels

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import kz.jusan.singularityroombooking.data.remote.toRoomBooking
import kz.jusan.singularityroombooking.domain.entities.RoomBooking
import kz.jusan.singularityroombooking.domain.repository.RoomBookingRepository
import javax.inject.Inject

@HiltViewModel
class RoomBookingViewModel @Inject constructor(
    private val repository: RoomBookingRepository
) : ViewModel() {

    private var _roomBookings = MutableLiveData<List<RoomBooking>>()
    var roomBookings: LiveData<List<RoomBooking>> = _roomBookings

    fun loadRoomBookings(roomName: String) {
        viewModelScope.launch {
            val resultsResponse = repository.getRoomBookings(roomName)
            val resultsList = resultsResponse.body()?.toList()
            val resultsListConverted = resultsList!!.map {
                it.toRoomBooking()
            }
            _roomBookings.postValue(resultsListConverted)
        }
    }

}