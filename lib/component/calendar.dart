import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'event.dart';

class Event {
  final DateTime date ;
  Event({required this.date});
}

class Calendar extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;

  const Calendar({
    Key? key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final defaultBoxDeco = BoxDecoration(
      border: Border.all(
        width: 0.5,
        color: Colors.grey.shade200,
      ),
    );

    final textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 15,
    );

    return TableCalendar(

      rowHeight: 70.0,
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      daysOfWeekHeight: 40.0,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        headerPadding: EdgeInsets.symmetric(horizontal: 100),
        titleCentered: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0),
      ),
      calendarStyle: CalendarStyle(
        cellPadding: const EdgeInsets.only(top: 8, right: 8),
        cellAlignment: Alignment.topRight,
        cellMargin: const EdgeInsets.all(0),
        isTodayHighlighted: false,
        defaultDecoration: defaultBoxDeco,
        weekendDecoration: defaultBoxDeco,
        outsideDecoration: defaultBoxDeco,
        selectedTextStyle: textStyle,
        selectedDecoration: const BoxDecoration(
          color: Color.fromRGBO(167, 186, 254, 0.3),
          shape: BoxShape.rectangle,
        ),
        defaultTextStyle: textStyle,
        weekendTextStyle: textStyle.copyWith(color: Colors.blue),
        outsideTextStyle: textStyle.copyWith(fontSize: 13.0),
        markerDecoration: BoxDecoration(
          color: Colors.green,
        ),
        markerSize: 20,
        markersAlignment: Alignment.bottomCenter,
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          if (day.weekday == DateTime.sunday) {
            return const Center(
              child: Text(
                '일',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
        },
        defaultBuilder: (context, day, focusedDay) {
          if (day.weekday == DateTime.sunday) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 0.5,
                ),
              ),
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(top: 8, right: 8),
              child: Text(
                day.day.toString(),
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }
        },
        // markerBuilder: (context, day, events) {
        //   if(day.day == 7){
        //     return Container(
        //       child: Positioned(
        //         bottom: 1,
        //         child: ,
        //       ),
        //     );
        //   }
        // },
      ),
      eventLoader: (day) {
        if(day.day == 7 || day.day == 8 || day.day == 9){
          return ['hi'];
        }
        return [];
      },
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        if (selectedDay == null) {
          return false;
        }
        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}
