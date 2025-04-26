import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationController extends GetxController {
  var educationList = <Map<String, TextEditingController>>[].obs;

  void addEducation() {
    educationList.add({
      'institute': TextEditingController(),
      'field': TextEditingController(),
      'startDate': TextEditingController(),
      'endDate': TextEditingController(),
      'grade': TextEditingController(),
    });
  }

  void removeEducation(int index) {
    educationList.removeAt(index);
  }

  void disposeControllers() {
    for (var item in educationList) {
      item.values.forEach((controller) => controller.dispose());
    }
    educationList.clear();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }
}
