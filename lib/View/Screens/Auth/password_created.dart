import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/View/Screens/Auth/login_screen.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/constants/gradient.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';

class Password_created extends StatefulWidget {
  const Password_created({Key? key}) : super(key: key);

  @override
  State<Password_created> createState() => _Password_createdState();
}

class _Password_createdState extends State<Password_created> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 69.h),
              Container(
                width: 152.w,
                height: 152.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.r),
                  child: Image.asset(
                    'assets/images/pass1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text('New Password Created!',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants().textColor)),
              SizedBox(height: 400.h),
              RoundButton(
                title: 'Continue',
                onTap: () {
                  Get.to(() => const Login_Screen());
                },
                color: ColorConstants().buttonColor,
                isloading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
