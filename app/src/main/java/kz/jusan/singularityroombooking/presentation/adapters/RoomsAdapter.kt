package kz.jusan.singularityroombooking.presentation.adapters

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.AsyncListDiffer
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import kz.jusan.singularityroombooking.R
import kz.jusan.singularityroombooking.domain.entities.Room

class RoomsAdapter : RecyclerView.Adapter<RoomsAdapter.RoomViewHolder>() {

    inner class RoomViewHolder(itemView: View): RecyclerView.ViewHolder(itemView)

    private val diffCallback = object : DiffUtil.ItemCallback<Room>() {
        override fun areItemsTheSame(oldItem: Room, newItem: Room): Boolean {
            return oldItem.displayName == newItem.displayName
        }

        override fun areContentsTheSame(oldItem: Room, newItem: Room): Boolean {
            return oldItem.hashCode() == newItem.hashCode()
        }
    }

    val differ = AsyncListDiffer(this, diffCallback)

    var rooms: List<Room>
        get() = differ.currentList
        set(value) = differ.submitList(value)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RoomViewHolder {
        return RoomViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.rv_room,
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: RoomViewHolder, position: Int) {
        val room = rooms[position]
        holder.itemView.apply {
            findViewById<ImageView>(R.id.ivRoomPhoto).setImageResource(room.photo)
            findViewById<TextView>(R.id.tvRoomName).text = room.displayName

            setOnClickListener {
                onRoomClickListener?.let { click ->
                    click(room)
                }
            }
        }
    }

    private var onRoomClickListener: ((Room) -> Unit)? = null

    fun setRoomClickListener(listener: (Room) -> Unit) {
        onRoomClickListener = listener
    }

    override fun getItemCount(): Int {
        return rooms.size
    }

}