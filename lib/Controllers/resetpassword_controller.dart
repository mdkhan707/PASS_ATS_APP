import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pass_ats/View/Screens/Auth/password_created.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> resetPassword() async {
    String email = emailController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      isLoading.value = true;

      var response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/auth/reset-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'newPassword': newPassword,
          'confirmPassword': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Password reset successful",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.off(() => const Password_created());
      } else {
        var errorMessage = jsonDecode(response.body)['message'];
        Get.snackbar("Error", errorMessage ?? "Something went wrong",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to connect to the server",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
