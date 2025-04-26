import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pass_ats/View/Screens/Auth/login_screen.dart';
import 'package:pass_ats/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  void checkLoginStatus(BuildContext context, Function stopLoading) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    Timer(const Duration(seconds: 4), () {
      stopLoading();
      if (token != null && token.isNotEmpty) {
        // User is already logged in, navigate to Home Screen
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const Custom_NavigationBar()));
      } else {
        // User is not logged in, navigate to Login Screen
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Login_Screen()));
      }
    });
  }
}
