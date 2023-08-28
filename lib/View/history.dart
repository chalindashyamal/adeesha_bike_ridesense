import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'triplist.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final firestoreInstance = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  List<Module> trips = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchModulesData();
  }

  Future<void> fetchModulesData() async {
    try {
      final snapshot = await firestoreInstance
          .collection("users")
          .doc(user!.uid)
          .collection("trips")
          .get();

      trips = snapshot.docs.map((doc) {
        Timestamp timestamp = doc.get("date");
        DateTime dateTime = timestamp.toDate();
        return Module(
          tripID: doc.id,
          date: dateTime,
        );
      }).toList();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      AppToastmsg.appToastMeassage("Error fetching modules data: $e");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Show loading indicator
            )
          : trips.isEmpty
              ? Center(
                  child: Text('No trips available.'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const SizedBox(height: 100),
                              Container(
                                width: 13,
                                height: 13,
                                color: Colors.red,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text("High risk"),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 13,
                                height: 13,
                                color: Colors.yellow,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text("Low risk"),
                              )
                            ],
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: trips.length,
                        itemBuilder: (context, index) {
                          String formattedDate = DateFormat('yyyy-MM-dd')
                              .format(trips[index].date);
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1.0, color: Colors.grey)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.grey)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: Text("01")),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              formattedDate,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                            const Text(
                                              "Colombo to Kandy",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        CircularPercentIndicator(
                                          radius: 25.0,
                                          lineWidth: 7.0,
                                          animation: true,
                                          percent: 0.7,
                                          circularStrokeCap:
                                              CircularStrokeCap.round,
                                          progressColor: Colors.red,
                                          backgroundColor: Colors.yellow,
                                        ),
                                        const SizedBox(height: 5),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Triplist(
                                                    tripid:
                                                        trips[index].tripID),
                                              ),
                                            );
                                          },
                                          child: const Text("See more"),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10)
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
    );
  }
}

class Module {
  final String tripID;
  final DateTime date;

  Module({
    required this.tripID,
    required this.date,
  });
}

class AppToastmsg {
  static void appToastMeassage(String message) {
    // Implement your toast logic
  }
}
