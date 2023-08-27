import 'package:adeesha_bike_ridesense/View/widgets/signupbutton.global.dart';
import 'package:adeesha_bike_ridesense/View/widgets/text.form.global.dart';
import 'package:flutter/material.dart';

import '../utils/global.colors.dart';
import 'login.view.dart';


class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                const SizedBox(height: 50),
                Text(
                  'Sign up for an account',
                  style: TextStyle(
                      color: GlobalColor.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                // Email Input
                TextFormGlobal(
                  controller: emailController,
                  text: 'Email',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                // username Input
                TextFormGlobal(
                  controller: emailController,
                  text: 'User Name',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                // address Input
                TextFormGlobal(
                  controller: emailController,
                  text: 'Address',
                  obscure: false,
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                // Password input
                TextFormGlobal(
                  controller: passwordController,
                  text: 'Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),
                const SizedBox(height: 20),
                // Confirm Password input
                TextFormGlobal(
                  controller: confirmPasswordController,
                  text: 'Confirm Password',
                  textInputType: TextInputType.text,
                  obscure: true,
                ),
                const SizedBox(height: 10),
                const ButtonGlobal1(),
                const SizedBox(height: 25),
                // const SocialSignup(),
                const SizedBox(height: 50),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginView()), // Navigate to the LoginView
                      );
                    },
                    child: const Text(
                      "Already have an account? Sign in",
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
