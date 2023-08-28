import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../components/flutter_toast.dart';
import 'Evidence/Evidence.dart';
import 'map.dart';

class LastTrip extends StatefulWidget {
  const LastTrip({super.key});

  @override
  State<LastTrip> createState() => _LastTripState();
}

class _LastTripState extends State<LastTrip> {
  final firestoreInstance = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  String? latestTripID;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLatestTrip();
  }

  Future<void> fetchLatestTrip() async {
    try {
      final snapshot = await firestoreInstance
          .collection("users")
          .doc(user!.uid)
          .collection("trips")
          .orderBy("date", descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        setState(() {
          latestTripID = doc.id;
          isLoading = false;
        });
      } else {
        setState(() {
          latestTripID = null;
          isLoading = false;
        });
      }
    } catch (e) {
      AppToastmsg.appToastMeassage("Error fetching latest trip data: $e");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Last Trip/Dashboard'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: firestoreInstance
            .collection("users")
            .doc(user!.uid)
            .collection("trips")
            .doc(latestTripID)
            .collection("incident")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          List<QueryDocumentSnapshot> incidentList = snapshot.data!.docs;
          double totalOverallRisk = 0.0;
          int totalIncidents = incidentList.length;

          for (var incidentSnapshot in incidentList) {
            double speed = (incidentSnapshot['speed'] as num).toDouble();
            int angle = incidentSnapshot['angle'];

            double overallRisk = prerisk(angle, speed);
            totalOverallRisk += overallRisk;
          }

          double minOverallRisk = double.infinity;
          double maxOverallRisk = 0.0;

          for (var incidentSnapshot in incidentList) {
            double speed = (incidentSnapshot['speed'] as num).toDouble();
            int angle = incidentSnapshot['angle'];

            double overallRisk = prerisk(angle, speed);
            if (overallRisk < minOverallRisk) {
              minOverallRisk = overallRisk;
            }
            if (overallRisk > maxOverallRisk) {
              maxOverallRisk = overallRisk;
            }
          }

          double maxAngle = -1;
          double maxAngleSpeed = 0.0;

          for (var incidentSnapshot in incidentList) {
            double speed = (incidentSnapshot['speed'] as num).toDouble();
            int angle = incidentSnapshot['angle'];

            double overallRisk = prerisk(angle, speed);
            if (angle.toDouble() > maxAngle) {
              maxAngle = angle.toDouble();
              maxAngleSpeed = speed;
            }
          }
          double averageRisk =
              totalIncidents > 0 ? totalOverallRisk / totalIncidents : 0.0;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Colombo to Kandy",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              CircularPercentIndicator(
                radius: 70.0,
                lineWidth: 12.0,
                animation: true,
                percent: averageRisk / 100,
                center: Text(
                  "$averageRisk%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                progressColor: Colors.blue,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 12.0,
                    animation: true,
                    percent: minOverallRisk / 100,
                    center: Text(
                      "$minOverallRisk%",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    progressColor: Colors.blue,
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "Low Risk",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 12.0,
                    animation: true,
                    percent: maxOverallRisk / 100,
                    center: Text(
                      "$maxOverallRisk%",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    progressColor: Colors.blue,
                    footer: const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "High Risk",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Risk Speed ${maxAngleSpeed}Kmh"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Evidence(evidenceTrip: latestTripID.toString()),
                          ),
                        );
                      },
                      child: const Text("Evidence")),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MapScreen(mapid: latestTripID.toString()),
                        ),
                      );
                    },
                    child: const Text("Map"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: averageRisk > 50
                    ? const Text("Your ride is risky")
                    : const Text("Your ride is safe"),
              )
            ],
          );
        },
      ),
    );
  }

  double prerisk(int angle, double speed) {
    double speedRisk = calculateSpeedRisk(speed);
    double angleRisk = calculateAngleRisk(angle, speed);
    double overallRisk = (speedRisk + angleRisk) / 2;

    return overallRisk;
  }

  double calculateSpeedRisk(double speed) {
    if (speed <= 10) {
      return 0.0;
    } else if (speed <= 20) {
      return 20.0;
    } else if (speed <= 40) {
      return 40.0;
    } else if (speed <= 60) {
      return 60.0;
    } else if (speed <= 80) {
      return 80.0;
    } else {
      return 100.0;
    }
  }

  double calculateAngleRisk(int angle, double speed) {
    if (speed <= 10.0 && angle <= 2) {
      return 0.0;
    } else if (speed <= 10.0 && angle <= 18) {
      return 20.0;
    } else if (speed <= 10.0 && angle <= 36) {
      return 40.0;
    } else if (speed <= 10.0 && angle <= 54) {
      return 60.0;
    } else if (speed <= 10.0 && angle <= 72) {
      return 80.0;
    } else if (speed <= 10.0) {
      return 0.0;
    } else {
      return 100.0;
    }
  }
}
