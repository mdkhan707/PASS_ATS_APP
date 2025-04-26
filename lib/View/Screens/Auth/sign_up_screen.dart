import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/sign_up_controller.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Screens/Auth/login_screen.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/custom_text_Field.dart';
import 'package:pass_ats/View/Widgets/google_round_button.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  final signUpController = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 100.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign Up to your account',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants().textColor)),
              SizedBox(height: 4.h),
              // App Name
              Text(
                'Welcome back to passATS',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants().textColor,
                ),
              ),
              SizedBox(height: 20.h),
              CustomTextField(
                controller: signUpController.nameController,
                title: 'Enter Your Name',
                icon: Icons.person,
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                  controller: signUpController.emailController,
                  title: 'Enter Email',
                  icon: Icons.email_outlined),
              SizedBox(height: 15.h),
              CustomTextField(
                  controller: signUpController.phoneController,
                  title: 'Phone Number',
                  icon: Icons.phone),
              SizedBox(height: 15.h),
              CustomTextField(
                  controller: signUpController.passwordController,
                  title: 'Enter password',
                  icon: Icons.lock),
              SizedBox(height: 15.h),
              CustomTextField(
                  controller: signUpController.confirmPasswordController,
                  title: 'Confirm password',
                  icon: Icons.lock),
              SizedBox(height: 30.h),
              Obx(() {
                return signUpController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(), // Loading Indicator
                      )
                    : RoundButton(
                        title: 'Sign Up',
                        onTap: () {
                          signUpController.registerUser();
                        },
                        color: ColorConstants().buttonColor,
                        isloading: false,
                      );
              }),

              SizedBox(height: 30.h),
              GoogleRoundButton(
                title: 'Sign In with Google',
                onTap: () {
                  // Google Sign In Controller
                },
                color: Colors.white,
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorConstants().textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const Login_Screen());
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants().textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
