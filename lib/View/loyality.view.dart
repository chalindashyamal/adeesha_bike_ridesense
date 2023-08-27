
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/linechart.dart';

class LoyalityView extends StatefulWidget {
  const LoyalityView({super.key});

  @override
  State<LoyalityView> createState() => _LoyalityViewState();
}

class _LoyalityViewState extends State<LoyalityView> {

  bool isValidForm = false;
   final _formKey = GlobalKey<FormState>();

   Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
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
                            Text("full name",style: TextStyle(),),
                            Icon(Icons.beenhere,color: Colors.blue,)
                          ],
                        ),
                        Text("email",style: TextStyle(),),
                        Text("address",style: TextStyle(),),
                      ],
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
                              Text("100"),
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