import 'package:adeesha_bike_ridesense/View/history.dart';
import 'package:adeesha_bike_ridesense/View/lasttrip.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'View/Evidence/Evidence.dart';
import 'View/loyality.view.dart';
import 'View/map.dart';
import 'View/menu.dart';
import 'View/setting.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
       // useMaterial3: true,
      ),
      home:  History(),
    );
  }
}

