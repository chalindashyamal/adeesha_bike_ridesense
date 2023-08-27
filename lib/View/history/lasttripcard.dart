import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class LastTripCard extends StatefulWidget {
  const LastTripCard({super.key});

  @override
  State<LastTripCard> createState() => _LastTripCardState();
}

class _LastTripCardState extends State<LastTripCard> {
  @override
  Widget build(BuildContext context) {
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kandy to colombo"),
                  Image.network("https://picsum.photos/170/100", width: 170, height: 100,)
                ],
              ),
              Column(
                children: [
                  Text("75kmh"),
                  new CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 12.0,
                    animation: true,
                    percent: 0.7,
                    center: new Text(
                      "70.0%",
                      style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    footer: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: new Text(
                        "Risk Ride",
                        style:
                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    progressColor: Colors.blue,
                  ),
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