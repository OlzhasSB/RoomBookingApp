package kz.jusan.singularityroombooking.presentation.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.AsyncListDiffer
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import kz.jusan.singularityroombooking.R
import kz.jusan.singularityroombooking.domain.entities.RoomBooking
import java.time.LocalDateTime
import java.time.OffsetDateTime
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeFormatterBuilder
import java.util.*

class RoomBookingsAdapter : RecyclerView.Adapter<RoomBookingsAdapter.RoomBookingsViewHolder>() {

    inner class RoomBookingsViewHolder(itemView: View): RecyclerView.ViewHolder(itemView)

    private val diffCallback = object : DiffUtil.ItemCallback<RoomBooking>() {
        override fun areItemsTheSame(oldItem: RoomBooking, newItem: RoomBooking): Boolean {
            return oldItem.personName == newItem.personName
        }

        override fun areContentsTheSame(oldItem: RoomBooking, newItem: RoomBooking): Boolean {
            return oldItem.hashCode() == newItem.hashCode()
        }
    }

    val differ = AsyncListDiffer(this, diffCallback)

    var roomBookings: List<RoomBooking>
        get() = differ.currentList
        set(value) = differ.submitList(value)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RoomBookingsViewHolder {
        return RoomBookingsViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.rv_room_booking,
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: RoomBookingsViewHolder, position: Int) {
        val roomBooking = roomBookings[position]
        holder.itemView.apply {
            val pattern = "HH:mm, dd-MMM-uuuu"
            val fromDate = OffsetDateTime.parse(roomBooking.fromDate)
            val fromDateFormatted = DateTimeFormatter.ofPattern(pattern, Locale.ENGLISH)
            val toDate = OffsetDateTime.parse(roomBooking.toDate);
            val toDateFormatted = DateTimeFormatter.ofPattern(pattern, Locale.ENGLISH);

            findViewById<TextView>(R.id.tvFromContent).text = fromDateFormatted.format(fromDate)
            findViewById<TextView>(R.id.tvToContent).text = toDateFormatted.format(toDate)
            findViewById<TextView>(R.id.tvWhoContent).text = roomBooking.personName
            findViewById<TextView>(R.id.tvContactContent).text = roomBooking.contactInfo

            setOnClickListener {
                onRoomBookingClickListener?.let { click ->
                    click(roomBooking)
                }
            }
        }
    }

    private var onRoomBookingClickListener: ((RoomBooking) -> Unit)? = null

    fun setRoomBookingClickListener(listener: (RoomBooking) -> Unit) {
        onRoomBookingClickListener = listener
    }

    override fun getItemCount(): Int {
        return roomBookings.size
    }

}