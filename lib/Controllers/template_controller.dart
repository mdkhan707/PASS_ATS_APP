import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TemplateController extends GetxController {
  final String apiUrl = 'http://192.168.0.103/api/save-template';

  final String templateIdKey = 'selectedTemplateId';
  final String templateNameKey = 'selectedTemplateName';
  final String templateUrlKey = 'selectedTemplateUrl';

  RxString selectedTemplateId = ''.obs;
  RxString selectedTemplateName = ''.obs;
  RxString selectedTemplateUrl = ''.obs;

  // Save template locally and remotely
  Future<void> saveTemplate({
    required String userId,
    required String templateId,
    required String templateName,
    required String templateUrl,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save template locally
    await prefs.setString(templateIdKey, templateId);
    await prefs.setString(templateNameKey, templateName);
    await prefs.setString(templateUrlKey, templateUrl);

    // Update observable variables for reactive UI updates
    selectedTemplateId.value = templateId;
    selectedTemplateName.value = templateName;
    selectedTemplateUrl.value = templateUrl;

    // Save template remotely to MongoDB
    await saveTemplateToDatabase(
      userId: userId,
      templateId: templateId,
      templateName: templateName,
      templateUrl: templateUrl,
    );
  }

  // Send POST request to backend to save template
  Future<void> saveTemplateToDatabase({
    required String userId,
    required String templateId,
    required String templateName,
    required String templateUrl,
  }) async {
    try {
      // Send a POST request to the backend API
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': userId,
          'templateId': templateId,
          'templateName': templateName,
          'templateUrl': templateUrl,
        }),
      );

      // Check for successful response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        // Show success message
        Get.snackbar(
          "Template Saved",
          data['message'] ?? 'Template saved successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        // Handle server-side errors and non-200 responses
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          "Error",
          errorData['error'] ?? 'Failed to save template.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // Handle any network or other exceptions
      print('Error: $e');
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Load previously selected template from SharedPreferences
  Future<void> loadSelectedTemplate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedTemplateId.value = prefs.getString(templateIdKey) ?? '';
    selectedTemplateName.value = prefs.getString(templateNameKey) ?? '';
    selectedTemplateUrl.value = prefs.getString(templateUrlKey) ?? '';
  }
}
