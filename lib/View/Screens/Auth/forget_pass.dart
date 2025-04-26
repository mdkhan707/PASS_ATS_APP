import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/forgotpassword_controller.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/constants/gradient.dart';
import 'package:pass_ats/View/Screens/Auth/login_screen.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/custom_text_Field.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  // Initialize the controller
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 69.h),
                InkWell(
                  onTap: () {
                    Get.to(() => const Login_Screen());
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Forgot Your Password?',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please enter the email linked with your account!',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants().textColor,
                  ),
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  controller: controller.emailController,
                  title: 'Enter Email',
                  icon: Icons.email_outlined,
                ),
                const Spacer(),
                Obx(() => RoundButton(
                      title: 'Send Link',
                      onTap: () {
                        controller.forgotPassword();
                      },
                      color: ColorConstants().buttonColor,
                      isloading: controller.isLoading.value,
                    )),
                SizedBox(height: 30.h), // Extra space for safe area
              ],
            ),
          ),
        ),
      ),
    );
  }
}
