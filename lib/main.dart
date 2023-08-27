import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'View/history.dart';
import 'View/history/lasttrip.dart';
import 'View/login.view.dart';
import 'View/loyality.view.dart';
import 'View/splash.veiw.dart';
import 'View/static.dart';

void main() {
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
      home: StaticChart(),
    );
  }
}

