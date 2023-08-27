import 'package:flutter/material.dart';
import '../history.dart';



class LastTrip extends StatefulWidget {
  const LastTrip({super.key});

  @override
  State<LastTrip> createState() => _LastTripState();
}

class _LastTripState extends State<LastTrip> {
  List<Module> item = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return HistoryCard();
            },
          ),
        ),
      ),
    );
  }
}

class Module {
  final String remindID;
  final String title;
  final String note;
  final String date;
  final String time;
  final String remind;
  Module({
    required this.remindID,
    required this.title,
    required this.note,
    required this.date,
    required this.time,
    required this.remind,
  });
}