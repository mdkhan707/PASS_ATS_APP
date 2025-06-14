import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pass_ats/Models/resume_model.dart';
import 'dart:convert';

import 'package:pass_ats/constants/app_constants.dart';

class ResumeController extends GetxController {
  var resumeList = <ResumeTemplate>[].obs;
  var isLoading = true.obs; // Track loading state

  @override
  void onInit() {
    super.onInit();
    fetchResumes();
  }

  // Function to fetch resume templates
  Future<void> fetchResumes() async {
    try {
      isLoading(true); // Set loading to true while fetching
      final response =
          await http.get(Uri.parse("${AppConstants.apiUrl}/api/templates"));
      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        resumeList.value = data.map((e) => ResumeTemplate.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch templates");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false); // Set loading to false after fetching is complete
    }
  }

  // Get full URL for the PNG image
  String getFullImageUrl(String relativePath) =>
      "${AppConstants.apiUrl}$relativePath";

  // Get full URL for the PDF file
  String getFullPdfUrl(String relativePath) =>
      "${AppConstants.apiUrl}$relativePath";
}
