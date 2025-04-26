import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pass_ats/View/Screens/Auth/login_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  // Observable Loading State
  var isLoading = false.obs;

  // Save User Data after Signup
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', userData['token']);
    var user = userData['user'];
    await prefs.setString('name', user['name']);
    await prefs.setString('email', user['email']);
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  // TextEditingControllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // API Call Function
  void registerUser() async {
    // Check if any field is empty
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Check if passwords match
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Toggle Loading State
    isLoading.value = true;

    // API Call
    try {
      var url = Uri.parse('http://10.0.2.2:5000/api/auth/signup');
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'password': passwordController.text,
          'confirmPassword': confirmPasswordController.text
        }),
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);
        await saveUserData(jsonResponse);

        // Success Message
        Get.snackbar("Success", "User registered successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
        clearFields(); // Clear the fields after successful registration
        // Redirect to Home Screen
        Get.to(const Login_Screen());
      } else {
        var jsonResponse = jsonDecode(response.body);
        Get.snackbar("Error", jsonResponse['message'] ?? "Something went wrong",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to register. Try again later.",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
