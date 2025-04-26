import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/login_controller.dart';
import 'package:pass_ats/View/Screens/about_us_screen.dart';

class Custom_Drawer extends StatefulWidget {
  @override
  _Custom_DrawerState createState() => _Custom_DrawerState();
}

class _Custom_DrawerState extends State<Custom_Drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
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
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/app_logo.png', height: 100.h),
                const Divider(
                  color: Colors.white,
                  thickness: 1,
                ),
              ],
            ),
            ListTile(
              leading: Image.asset('assets/images/favourite.png', height: 25.h),
              title: const Text(
                'Favourtite templates',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              leading: Image.asset('assets/images/rate_us.png', height: 25.h),
              title: const Text(
                'Rate app',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              leading:
                  Image.asset('assets/images/private_policy.png', height: 25.h),
              title: const Text(
                'Private policy',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
            InkWell(
              onTap: () {
                Get.offAll(() => const AboutUsScreen());
              },
              child: ListTile(
                leading:
                    Image.asset('assets/images/about_us.png', height: 25.h),
                title: const Text(
                  'About us',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                LoginController().logoutUser();
              },
              child: const ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
