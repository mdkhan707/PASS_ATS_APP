import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/resetpassword_controller.dart';
import 'package:pass_ats/View/Screens/Auth/verify_email_screen.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/constants/gradient.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/custom_text_Field.dart';

class NewPasswordScreen extends StatelessWidget {
  // Initialize the controller
  final ResetPasswordController controller = Get.put(ResetPasswordController());

  NewPasswordScreen({Key? key}) : super(key: key);

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
                    Get.to(() => Verify_Email());
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Create New Password',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Enter a new password to regain access!',
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
                SizedBox(height: 30.h),
                CustomTextField(
                  controller: controller.newPasswordController,
                  title: 'Enter new password',
                  icon: Icons.lock,
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  controller: controller.confirmPasswordController,
                  title: 'Confirm new password',
                  icon: Icons.lock,
                ),
                const Spacer(),
                Obx(() => RoundButton(
                      title: 'Reset Password',
                      onTap: () {
                        if (!controller.isLoading.value) {
                          controller.resetPassword();
                        }
                      },
                      color: ColorConstants().buttonColor,
                      isloading: controller.isLoading.value,
                    )),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
