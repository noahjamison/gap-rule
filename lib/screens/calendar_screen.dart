import 'package:flutter/material.dart';
import 'package:gaprule/constants.dart';
import 'package:gaprule/widgets/rounded_button.dart';
import 'package:table_calendar/table_calendar.dart';

import 'search_results_screen.dart';

/// [CalendarScreen]
///
/// Shows the user a calendar where they can select a range of dates
/// to check for campsite availability.
class CalendarScreen extends StatefulWidget {
  static const String id = 'calendar_screen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.utc(2018, 6, 1);
  DateTime? _selectedDay;
  DateTime? _rangeStart = DateTime.utc(2018, 6, 4);
  DateTime? _rangeEnd = DateTime.utc(2018, 6, 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Reservation'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: CalendarFormat.month,
            rangeSelectionMode: _rangeSelectionMode,
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _rangeStart = null;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });
              }
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          RoundedButton(
            title: 'Check Availability',
            color: Colors.green,
            onPressed: () {
              DateTimeRange searchRange = DateTimeRange(
                start: _rangeStart ??
                    DateTime.utc(
                        2018, 6, 4), // Default search start date from JSON file
                end: _rangeEnd ??
                    DateTime.utc(
                        2018, 6, 6), // Default search end date from JSON file
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchResultsScreen(
                    searchRange: searchRange,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
