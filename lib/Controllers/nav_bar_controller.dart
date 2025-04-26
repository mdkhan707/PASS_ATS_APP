import 'package:get/get.dart';
import 'package:pass_ats/View/Screens/about_us_screen.dart';
import 'package:pass_ats/View/Screens/home_screen.dart';
import 'package:pass_ats/View/Screens/my_resume_screen.dart';

class NavBarController extends GetxController {
  final Rx<int> selectedindex = 0.obs;

  final Screens = [
    const HomeScreen(),
    const MyResumeScreen(),
    const AboutUsScreen(),
  ];
}
