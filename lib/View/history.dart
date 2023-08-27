import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Module> item = [];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               Row(
                 children: [ SizedBox(height: 100),
                   Container(
                     width: 13,
                     height:13,
                     color: Colors.red,
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 5),
                     child: Text("High risk"),
                   )
                 ],
               ),
               Row(
                 children: [
                   Container(
                     width: 13,
                     height:13,
                     color: Colors.yellow,
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 5),
                     child: Text("Low risk"),
                   )
                 ],
               ),
             ],
             ),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return HistoryCard();
                },
              ),
            ),
             
          ],
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




class HistoryCard extends StatefulWidget {
  const HistoryCard({super.key});

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  final DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final TextEditingController _dateController = TextEditingController(
      text: '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
    );
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1.0, color: Colors.grey)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(          
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1.0, color: Colors.grey)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(alignment: Alignment.center,child: Text("01")),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_dateController.text, style: TextStyle(fontSize: 15 ),),
                  Text("Colombo to Kandy", style: TextStyle(fontSize:15, fontWeight: FontWeight.bold),)
                ],
              )
                ],
              ),
              Column(
                children: [
                  new CircularPercentIndicator(
                    radius: 25.0,
                    lineWidth: 7.0,
                    animation: true,
                    percent: 0.7,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.red,
                    backgroundColor: Colors.yellow,
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text("See more"),
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}