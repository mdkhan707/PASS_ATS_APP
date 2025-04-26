import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleFieldController extends GetxController {
  var list = <TextEditingController>[].obs;

  void addField() {
    list.add(TextEditingController());
  }

  void removeField(int index) {
    list.removeAt(index);
  }

  void disposeControllers() {
    for (var ctrl in list) {
      ctrl.dispose();
    }
    list.clear();
  }

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }
}
