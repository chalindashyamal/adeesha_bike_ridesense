
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/flutter_toast.dart';
import '../components/linechart.dart';

class LoyalityView extends StatefulWidget {
  const LoyalityView({super.key});

  @override
  State<LoyalityView> createState() => _LoyalityViewState();
}

class _LoyalityViewState extends State<LoyalityView> {

  bool isValidForm = false;
   final _formKey = GlobalKey<FormState>();
   String points = "Loading...";

   Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    getUserData();
    fetchPoints();
  }

  Future<void> getUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Map<String, dynamic>? fetchedUserData = await fetchUserData(currentUser);
      setState(() {
        userData = fetchedUserData;
      });
    }
  }
  
  Future<Map<String, dynamic>?> fetchUserData(User user) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(user.uid)
            .get();
      if (userData.exists) {
        return userData.data();
      } else {
        AppToastmsg.appToastMeassage('User data not found in Firestore');
        return null;
      }
    } catch (e) {
      AppToastmsg.appToastMeassage('Failed to fetch user data: $e');

      return null;
    }
  }


  Future<void> fetchPoints() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> pointsSnapshot = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('points')
            .doc('PsVVqV0JVqqz79HI8KBf')
            .get();

        if (pointsSnapshot.exists) {
          setState(() {
            points = pointsSnapshot.data()?['value'] ?? "Value not found";
          });
        } else {
          print("Document not found");
        }
      } catch (e) {
        print("Failed to fetch points: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    String userName = userData?['username'] ?? 'N/A';
    String email = userData?['email'] ?? 'N/A';
    String address = userData?['address'] ?? 'N/A';
    
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(Icons.person_outline, color: Colors.blue,size: 100, ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(userName,style: TextStyle(),),
                            Icon(Icons.beenhere,color: Colors.blue,)
                          ],
                        ),
                        Text(email,style: TextStyle(),),
                        Text(address,style: TextStyle(),),
                      ],
                    ),
                    GestureDetector(child: Text("log out"),
                    onTap: signOut,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1.0, color: Colors.grey)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(points),
                              Text("Points"),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star,color: Colors.yellow),
                               Icon(Icons.star,color: Colors.yellow),
                              Icon(Icons.star),
                              Icon(Icons.star),
                              Icon(Icons.star),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                                Icon(Icons.star,color: Colors.yellow),
                              Text("200 star")
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Form(
          key: _formKey,
          child: 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Enter Mobile Number"
                  ),
                  validator: (inputValue){
                    if(inputValue!.isEmpty){
                      return "Please enter";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Enter Value"
                  ),
                  validator: (inputValue){
                    if(inputValue!.isEmpty){
                      return "Please Fill";
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                      setState(() {
                        isValidForm = true;
                      });
                  } else{
                    setState(() {
                        isValidForm = false;
                      });
                  }
              }, child: Text("20"),
              ),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                      setState(() {
                        isValidForm = true;
                      });
                  } else{
                    setState(() {
                        isValidForm = false;
                      });
                  }
              }, child: Text("50"),
              ),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                      setState(() {
                        isValidForm = true;
                      });
                  } else{
                    setState(() {
                        isValidForm = false;
                      });
                  }
              }, child: Text("100"),
              ),
                ],
              ),
              ElevatedButton(
                onPressed: (){
                  if(_formKey.currentState!.validate()){
                      setState(() {
                        isValidForm = true;
                      });
                  } else{
                    setState(() {
                        isValidForm = false;
                      });
                  }
              }, child: Text("Submit")),
            ],
          )
          ),
              LineChartSample2()    ],
          ),
        ),
      ),
    );
  }
}