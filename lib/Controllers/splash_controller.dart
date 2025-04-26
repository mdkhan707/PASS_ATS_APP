import 'package:get/get.dart';

class SplashController extends GetxController {
  // Observable variable to manage the loading state
  var isLoading = true.obs;

  // Method to stop the loading indicator
  void stopLoading() {
    isLoading.value = false;
  }
}
