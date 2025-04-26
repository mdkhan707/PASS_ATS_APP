import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/View/Screens/Auth/login_screen.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/constants/gradient.dart';

class GradientAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const GradientAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'Template Preview',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: ColorConstants().textColor,
            ),
          ),
          // centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_outlined, color: Colors.white),
            onPressed: () {
              Get.to(() => const Login_Screen());
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF000452),
                  Color(0xFF2A4596),
                  Color(0xFF000452),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
