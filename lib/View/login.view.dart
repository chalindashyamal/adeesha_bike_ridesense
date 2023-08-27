import 'package:adeesha_bike_ridesense/View/signup.view.dart';
import 'package:adeesha_bike_ridesense/View/widgets/signinbutton.global.dart';
import 'package:adeesha_bike_ridesense/View/widgets/text.form.global.dart';
import 'package:flutter/material.dart';

import '../utils/global.colors.dart';


class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'RIDESENSE',
                    style: TextStyle(
                      color: GlobalColor.mainColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ATTACK',
                    ),
                  ),
                ),
                const SizedBox(height: 50 ),
                Text(
                  'Login to your account',
  
                  style: TextStyle(
                      color: GlobalColor.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 45),
                // Email Input
                TextFormGlobal(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                // password input
                TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    textInputType: TextInputType.text,
                    obscure: true),
                const SizedBox(height: 10),
                const ButtonGlobal(),
                const SizedBox(height: 25),
                // const SocialLogin(),
                const SizedBox(height: 220),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignupView()), // Navigate to the SignupView
                      );
                    },
                    child: const Text(
                      "Don't have an account? Sign up here",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
