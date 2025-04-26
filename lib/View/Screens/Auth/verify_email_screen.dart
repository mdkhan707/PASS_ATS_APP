import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/verifycode_controller.dart';
import 'package:pass_ats/View/Screens/Auth/forget_pass.dart';
import 'package:pass_ats/View/Screens/Auth/new_pass_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/constants/gradient.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';

class Verify_Email extends StatelessWidget {
  final VerifyCodeController verifyCodeController =
      Get.put(VerifyCodeController());

  Verify_Email({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          GradientBackground(
            child: Container(),
          ),
          // Main Content with Scrolling
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 69.h),
                  InkWell(
                    onTap: () {
                      Get.to(() => ForgetPassword());
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    'Verify Your Email',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants().textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'We have sent a code to your email, please enter the code to verify your email!',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants().textColor,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  // Six-Digit Code Input Field
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: verifyCodeController.codeController,
                    onChanged: (value) {},
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8.r),
                      fieldHeight: 50.h,
                      fieldWidth: 40.w,
                      activeFillColor: ColorConstants().textFieldColor,
                      inactiveFillColor: ColorConstants().textFieldColor,
                      selectedFillColor: ColorConstants().textFieldColor,
                      activeColor: ColorConstants().buttonColor,
                      inactiveColor: ColorConstants().textFieldColor,
                      selectedColor: ColorConstants().buttonColor,
                    ),
                    cursorColor: ColorConstants().buttonColor,
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn\'t receive the code?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorConstants().textColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Resend code functionality here
                        },
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorConstants().textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
          // Positioned Button at Bottom
          Positioned(
            bottom: 30.h,
            left: 24.w,
            right: 24.w,
            child: RoundButton(
              title: 'Verify',
              onTap: () {
                if (verifyCodeController.codeController.text.length == 6) {
                  // Proceed if the code is complete
                  verifyCodeController.verifyCode();
                } else {
                  // Show a warning if the code is incomplete
                  Get.snackbar(
                    'Error',
                    'Please enter the 6-digit code',
                    colorText: Colors.white,
                    backgroundColor: Colors.cyan,
                  );
                }
              },
              color: ColorConstants().buttonColor,
              isloading: false,
            ),
          ),
        ],
      ),
    );
  }
}
