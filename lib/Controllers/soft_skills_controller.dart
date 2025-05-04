import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// Manages a dynamic list of TextEditingControllers for Soft Skills
class SoftSkillsController extends GetxController {
  final RxList<TextEditingController> list = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    // start with one empty field
    list.add(TextEditingController());
  }

  void addField() {
    list.add(TextEditingController());
  }

  void removeField(int i) {
    if (i < 0 || i >= list.length) return;
    list[i].dispose();
    list.removeAt(i);
  }

  @override
  void onClose() {
    for (var ctl in list) ctl.dispose();
    super.onClose();
  }
}
