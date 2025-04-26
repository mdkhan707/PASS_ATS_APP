import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/login_controller.dart';
import 'package:pass_ats/constants/gradient.dart';
import 'package:pass_ats/Controllers/splash_controller.dart';
import 'package:pass_ats/config/splash_services.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  final SplashServices _splashService = SplashServices();
  final SplashController _controller =
      Get.put(SplashController()); // Initialize the controller

  @override
  void initState() {
    super.initState();
    // Call the isLogin method with the controller's stopLoading callback
    _splashService.checkLoginStatus(context, _controller.stopLoading);
    Future.delayed(Duration(seconds: 2), () {
      Get.find<LoginController>().checkUserSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Icon
                  Container(
                    width: 152.w,
                    height: 152.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.r),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // App Name
                  Text(
                    'passATS',
                    style: TextStyle(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Use GetX to observe changes in loading state
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 50.h), // Adjust space from bottom
                child: Obx(() {
                  // Check if isLoading is true, show CircularProgressIndicator
                  if (_controller.isLoading.value) {
                    return const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    );
                  } else {
                    return const SizedBox(); // No indicator when loading is complete
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
