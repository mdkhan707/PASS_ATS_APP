import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

class SearchController extends GetxController {
  final Rx<TextEditingController> controller = TextEditingController().obs;
  final Rx<FocusNode> focusNode = FocusNode().obs;
  // Track whether the search bar is visible
  var isSearchBarVisible = false.obs;

  // Method to toggle the search bar
  void toggleSearchBar() {
    isSearchBarVisible.value = !isSearchBarVisible.value;
  }
}
