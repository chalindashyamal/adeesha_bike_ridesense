import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Evidence extends StatefulWidget {
  final String evidenceTrip;
  Evidence({Key? key, required this.evidenceTrip});

  @override
  _EvidenceState createState() => _EvidenceState();
}

class _EvidenceState extends State<Evidence> {
  final firestoreInstance = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  List<Module> incidents = [];
  bool isLoading = true;
  List<String> fromAddresses = [];

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
          .doc(widget.evidenceTrip) // Use the provided trip ID
          .collection("incident")
          .get();

      incidents = snapshot.docs.map((doc) {
        return Module(
          incidentId: doc.id,
          ridespeed: doc.get("speed").toDouble(),
          lat: doc.get("lat").toDouble(),
          lot: doc.get("lot").toDouble(),
          image: doc.get("cap"),
        );
      }).toList();
      
      await fetchAddressesForTrips();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching modules data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> fetchAddressesForTrips() async {
    for (int i = 0; i < incidents.length; i++) {
      double plat = incidents[i].lat;
      double plot = incidents[i].lot;
      Placemark fromPlace = (await placemarkFromCoordinates(plat, plot))[0];
      setState(() {
        fromAddresses.add(fromPlace.locality!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evidence'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: incidents.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1.0, color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${fromAddresses[index]}'),
                                  Image.network(
                                    incidents[index].image,
                                    width: 170,
                                    height: 100,
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(incidents[index]
                                      .ridespeed
                                      .toStringAsFixed(2)),
                                  CircularPercentIndicator(
                                    radius: 40.0,
                                    lineWidth: 12.0,
                                    animation: true,
                                    percent: 0.7,
                                    center: const Text(
                                      "70.0%",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    footer: const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Risk Ride",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                        ),
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
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}

class Module {
  final String incidentId;
  final double ridespeed;
  final double lat;
  final double lot;
  final String image;

  Module({
    required this.incidentId,
    required this.ridespeed,
    required this.lat,
    required this.lot,
    required this.image,
  });
}
