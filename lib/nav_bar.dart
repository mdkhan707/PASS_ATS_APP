import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/nav_bar_controller.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';

class Custom_NavigationBar extends StatefulWidget {
  const Custom_NavigationBar({super.key});

  @override
  State<Custom_NavigationBar> createState() => _Custom_NavigationBarState();
}

class _Custom_NavigationBarState extends State<Custom_NavigationBar> {
  final controller = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Obx(() => controller.Screens[controller.selectedindex.value]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000452),
                Color(0xFF2A4596),
                Color(0xFF000452),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            height: 60.h,
            selectedIndex: controller.selectedindex.value,
            onDestinationSelected: (index) {
              controller.selectedindex.value = index;
            },
            indicatorColor: Colors.transparent, // Optional highlight effect
            destinations: [
              NavigationDestination(
                icon: Image.asset(
                  'assets/images/home.png',
                  height: 30.h,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Image.asset(
                  'assets/images/cv.png',
                  height: 30.h,
                ),
                label: 'My Resume',
              ),
              NavigationDestination(
                icon: Image.asset(
                  'assets/images/about_us_1.png',
                  height: 30.h,
                ),
                label: 'About Us',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
