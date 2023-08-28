import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/global.colors.dart';
import 'login.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginView());
    });
    return Scaffold(
      backgroundColor: GlobalColor.mainColor,
      body: const Center(
        child: Text(
          'RIDESENSE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: 'ATTACK',
          ),
        ),
      ),
    );
  }
}
