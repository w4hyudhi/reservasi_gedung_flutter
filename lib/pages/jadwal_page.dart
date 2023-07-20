import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';

import '../models/bisnis.dart';
import 'package:intl/intl.dart';

class JadwalPage extends StatefulWidget {
  final List<Booking>? data;
  const JadwalPage({Key? key, this.data}) : super(key: key);

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  List<Booking>? bookingList;

  List<NeatCleanCalendarEvent> _todaysEvents = [];
  // List<NeatCleanCalendarEvent> _eventList = [
  //   NeatCleanCalendarEvent('Normal Event E',
  //       description: 'test desc',
  //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
  //           DateTime.now().day, 7, 45),
  //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
  //           DateTime.now().day, 9, 0),
  //       color: Colors.indigo),
  // ];

  Color getRandomColor() {
    Random random = Random();
    int r = random.nextInt(
        256); // Generar valor aleatorio para el componente rojo (0-255)
    int g = random.nextInt(
        256); // Generar valor aleatorio para el componente verde (0-255)
    int b = random.nextInt(
        256); // Generar valor aleatorio para el componente azul (0-255)
    return Color.fromARGB(
        255, r, g, b); // Crear un objeto Color con los componentes generados
  }

  @override
  void initState() {
    super.initState();
    convertBookingToCalendarEvent();
    // Force selection of today on first load, so that the list of today's events gets shown.
    _handleNewDate(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day));
  }

  void convertBookingToCalendarEvent() {}

  @override
  Widget build(BuildContext context) {
    bookingList = widget.data;
    if (bookingList != null) {
      List<NeatCleanCalendarEvent> convertedList = bookingList!.map((booking) {
        String dateTimeIN = booking.dateIn! + " " + booking.timeIn!;
        String dateTimeOUT = booking.dateOut! + " " + booking.timeOut!;
        DateTime dateTimeIn = DateFormat("yyyy-MM-dd HH:mm").parse(dateTimeIN);
        DateTime dateTimeOut =
            DateFormat("yyyy-MM-dd HH:mm").parse(dateTimeOUT);
        // Konversi objek Booking menjadi NeatCleanCalendarEvent
        return NeatCleanCalendarEvent(
          booking.nama!,
          startTime: dateTimeIn,
          endTime: dateTimeOut,
          description: 'Booking ID: ${booking.noRef}',
          color: getRandomColor(), // Ganti dengan warna yang sesuai
        );
      }).toList();

      setState(() {
        // Update _todaysEvents dan _eventList dengan convertedList
        _todaysEvents.addAll(convertedList);
      });
    }
    return Container(
      child: Calendar(
        startOnMonday: true,
        weekDays: ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Ming'],
        eventsList: _todaysEvents,
        isExpandable: true,
        eventDoneColor: Colors.green,
        selectedColor: Colors.pink,
        selectedTodayColor: Colors.green,
        todayColor: Colors.blue,
        eventColor: null,
        locale: 'id_ID',
        todayButtonText: 'Hari Ini',
        allDayEventText: 'Satu Hari',
        multiDayEndText: 'Selesai',
        isExpanded: true,
        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
        onEventSelected: (value) {
          print('Event selected ${value.summary}');
        },
        onEventLongPressed: (value) {
          print('Event long pressed ${value.summary}');
        },
        datePickerType: DatePickerType.date,
        dayOfWeekStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
      ),
    );
  }

  void _handleNewDate(date) {
    print('Date selected: $date');
  }
}
