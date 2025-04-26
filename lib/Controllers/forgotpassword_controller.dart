import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pass_ats/View/Screens/Auth/verify_email_screen.dart';

class ForgotPasswordController extends GetxController {
  // Loading State
  var isLoading = false.obs;

  // TextEditingController for Email
  final codecontroller = TextEditingController();
  final emailController = TextEditingController();

  // Forgot Password Function
  void forgotPassword() async {
    // Check if email field is empty
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Email is required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Toggle Loading State
    isLoading.value = true;

    // API Call
    try {
      var url = Uri.parse('http://10.0.2.2:5000/api/auth/forgot-password');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
        }),
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Success
        Get.snackbar("Success", "Reset code sent to your email.",
            backgroundColor: Colors.green, colorText: Colors.white);

        Get.to(() => Verify_Email());
      } else {
        // Error
        var jsonResponse = jsonDecode(response.body);
        Get.snackbar(
            "Error", jsonResponse['message'] ?? "Failed to send reset code",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Exception Handling
      Get.snackbar("Error", "Failed to send reset code. Try again later.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      // Stop Loading Indicator
      isLoading.value = false;
    }
  }
}
