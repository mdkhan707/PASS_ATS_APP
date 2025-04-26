import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pass_ats/View/Screens/Auth/new_pass_screen.dart';

class VerifyCodeController extends GetxController {
  // Loading State
  var isLoading = false.obs;

  // TextEditingController for Code Input
  final codeController = TextEditingController();

  // Verify Code Function
  void verifyCode() async {
    // Check if code field is empty
    if (codeController.text.isEmpty) {
      Get.snackbar("Error", "Verification code is required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Toggle Loading State
    isLoading.value = true;

    // API Call
    try {
      var url = Uri.parse('http://10.0.2.2:5000/api/auth/verify-code');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'code': codeController.text,
        }),
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Success
        var jsonResponse = jsonDecode(response.body);
        Get.snackbar("Success", jsonResponse['message'] ?? "Code Verified!",
            backgroundColor: Colors.green, colorText: Colors.white);

        Get.to(() => NewPasswordScreen());
      } else {
        // Error
        var jsonResponse = jsonDecode(response.body);
        Get.snackbar("Error", jsonResponse['message'] ?? "Invalid code",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Exception Handling
      Get.snackbar("Error", "Failed to verify code. Try again later.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      // Stop Loading Indicator
      isLoading.value = false;
    }
  }
}
