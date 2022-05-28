import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2020, 10, 1),
                lastDay: DateTime.utc(2040, 10, 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
