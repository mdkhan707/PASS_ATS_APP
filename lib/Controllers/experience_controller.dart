import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExperienceController extends GetxController {
  var experiences = <Map<String, TextEditingController>>[].obs;

  void addExperience() {
    experiences.add({
      'jobTitle': TextEditingController(),
      'organization': TextEditingController(),
      'startDate': TextEditingController(),
      'endDate': TextEditingController(),
      'description': TextEditingController(),
    });
  }

  void removeExperience(int index) {
    experiences.removeAt(index);
  }

  void disposeControllers() {
    for (var item in experiences) {
      item.values.forEach((controller) => controller.dispose());
    }
    experiences.clear();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }
}
