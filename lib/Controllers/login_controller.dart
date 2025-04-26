import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pass_ats/nav_bar.dart';
import 'package:pass_ats/View/Screens/Auth/login_screen.dart';

class LoginController extends GetxController {
  // Loading State
  var isLoading = false.obs;

  // TextEditingControllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  // Save User Token
  Future<void> saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Get User Token
  Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Remove User Token (Logout)
  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    Get.offAll(() => const Login_Screen()); // Redirect to login
  }

  // Check User Session on App Start
  Future<void> checkUserSession() async {
    String? token = await getUserToken();
    if (token != null && token.isNotEmpty) {
      Get.offAll(() => const Custom_NavigationBar()); // Go to Home Screen
    } else {
      Get.offAll(() => const Login_Screen()); // Redirect to Login
    }
  }

  // Login Function
  void loginUser() async {
    // Check if fields are empty
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Toggle Loading State
    isLoading.value = true;

    // API Call
    try {
      var url = Uri.parse('http://10.0.2.2:5000/api/auth/signin');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Success
        var jsonResponse = jsonDecode(response.body);
        Get.snackbar("Success", "Login successful!",
            backgroundColor: Colors.green, colorText: Colors.white);

        clearFields();
        // ✅ Save the token
        await saveUserToken(jsonResponse['token']);

        // Navigate to Home Screen
        Get.to(() => const Custom_NavigationBar());
      } else {
        // Error
        var jsonResponse = jsonDecode(response.body);
        Get.snackbar("Error", jsonResponse['message'] ?? "Login failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Exception Handling
      Get.snackbar("Error", "Failed to login. Try again later.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      // Stop Loading Indicator
      isLoading.value = false;
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void googleSignInUser() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        Get.snackbar("Cancelled", "Google Sign-In was cancelled");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final String email = googleUser.email;
      final String name = googleUser.displayName ?? "";
      final String profilePic = googleUser.photoUrl ?? "";
      final String fcmToken = "dummy_fcm_token";

      final Map<String, dynamic> userData = {
        "email": email,
        "name": name,
        "profilePic": profilePic,
        "contact": "",
        "language": "en",
        "fcmToken": fcmToken,
      };

      isLoading.value = true;

      final response = await http.post(
        Uri.parse("http://10.0.2.2:5000/api/auth/google-signin"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userData),
      );

      print('Google Sign-In Status Code: ${response.statusCode}');
      print('Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        await saveUserToken(jsonResponse['token']);

        Get.snackbar("Success", "Google Sign-In Successful!",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAll(() => const Custom_NavigationBar());
      } else {
        final jsonResponse = jsonDecode(response.body);
        Get.snackbar(
            "Error", jsonResponse['message'] ?? "Google Sign-In failed",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Google Sign-In failed: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
