package kz.jusan.singularityroombooking.presentation.dialogs

import android.app.DatePickerDialog
import android.app.DatePickerDialog.OnDateSetListener
import android.app.TimePickerDialog
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.lifecycle.lifecycleScope
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.google.android.material.textfield.TextInputEditText
import kotlinx.coroutines.launch
import kz.jusan.singularityroombooking.R
import kz.jusan.singularityroombooking.data.remote.AddRoomBookingDto
import kz.jusan.singularityroombooking.domain.repository.RoomBookingRepository
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.text.SimpleDateFormat
import java.time.LocalDateTime
import java.util.*
import javax.inject.Inject


class AddBookingBottomSheetDialog @Inject constructor(
    private val repository: RoomBookingRepository
) : BottomSheetDialogFragment() {

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val currentView =
            inflater.inflate(R.layout.dialog_bottomsheet_add_booking, container, false)

        val dateFrom = currentView.findViewById<TextInputEditText>(R.id.tietDateFrom)
        val timeFrom = currentView.findViewById<TextInputEditText>(R.id.tietTimeFrom)
        val dateTo = currentView.findViewById<TextInputEditText>(R.id.tietDateTo)
        val timeto = currentView.findViewById<TextInputEditText>(R.id.tietTimeTo)
        val name = currentView.findViewById<TextInputEditText>(R.id.tietName)
        val contactInfo = currentView.findViewById<TextInputEditText>(R.id.tietContactInfo)
        val btnAddBooking = currentView.findViewById<Button>(R.id.btnAddBooking)

        val dateFormat = SimpleDateFormat("dd-MMM-yyyy", Locale.ENGLISH)
        val myCalendar = Calendar.getInstance();

        val dateFromListener = OnDateSetListener { _, year, month, day ->
            myCalendar.set(Calendar.YEAR, year)
            myCalendar.set(Calendar.MONTH, month)
            myCalendar.set(Calendar.DAY_OF_MONTH, day)
            dateFrom.setText(dateFormat.format(myCalendar.time))
        }

        dateFrom.setOnClickListener {
            DatePickerDialog(
                currentView.context,
                dateFromListener,
                myCalendar[Calendar.YEAR],
                myCalendar[Calendar.MONTH],
                myCalendar[Calendar.DAY_OF_MONTH]
            ).show()
        }

        val dateToListener = OnDateSetListener { _, year, month, day ->
            myCalendar.set(Calendar.YEAR, year)
            myCalendar.set(Calendar.MONTH, month)
            myCalendar.set(Calendar.DAY_OF_MONTH, day)
            dateTo.setText(dateFormat.format(myCalendar.time))
        }

        dateTo.setOnClickListener {
            DatePickerDialog(
                currentView.context,
                dateToListener,
                myCalendar[Calendar.YEAR],
                myCalendar[Calendar.MONTH],
                myCalendar[Calendar.DAY_OF_MONTH]
            ).show()
        }

        val timeFromListener = TimePickerDialog.OnTimeSetListener { _, hour, minute ->
            val time = "$hour:$minute"
            val timeFormat = SimpleDateFormat("HH:mm", Locale.ENGLISH);
            timeFrom.setText(time.format(timeFormat))
        }

        timeFrom.setOnClickListener {
            TimePickerDialog(
                currentView.context,
                timeFromListener,
                12,
                0,
                false
            ).show()
        }

        val timeToListener = TimePickerDialog.OnTimeSetListener { _, hour, minute ->
            val time = "$hour:$minute"
            val timeFormat = SimpleDateFormat("HH:mm", Locale.ENGLISH);
            timeto.setText(time.format(timeFormat))
        }

        timeto.setOnClickListener {
            TimePickerDialog(
                currentView.context,
                timeToListener,
                12,
                0,
                false
            ).show()
        }

        btnAddBooking.setOnClickListener {
            // 12:00, 24-Jun-2022
            val sdf = SimpleDateFormat("HH:mm, dd-MMM-yyyy", Locale.ENGLISH)
            // 2022-06-23T10:04:37.962+00:00
            val output = SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ", Locale.ENGLISH)

            val timeFromForm = "${timeFrom.text}, ${dateFrom.text}"
            val dateFromForm = sdf.parse(timeFromForm)
            val formattedDateFromForm = output.format(dateFromForm!!)

            val timeToForm = "${timeto.text}, ${dateTo.text}"
            val dateToForm =  sdf.parse(timeToForm)
            val formattedDateToForm = output.format(dateToForm!!)

            val nameForm = name.text.toString()
            val contactForm = contactInfo.text.toString()

            val roomName = arguments?.getString("roomName") ?: "tennis"

            lifecycleScope.launch {
                repository.addRoomBooking(
                    roomName,
                    AddRoomBookingDto(
                        nameForm,
                        formattedDateFromForm,
                        formattedDateToForm,
                        contactForm
                    )
                )
            }
            dismiss()
        }

        return currentView
    }

}