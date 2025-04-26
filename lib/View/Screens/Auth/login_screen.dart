import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/login_controller.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Screens/Auth/forget_pass.dart';
import 'package:pass_ats/View/Screens/Auth/sign_up_screen.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/custom_text_Field.dart';
import 'package:pass_ats/View/Widgets/google_round_button.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final loginController = Get.put(LoginController());
  // final GoogleSignInController googleSignInController =
  //     Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 100.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sign In to your account',
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
              SizedBox(height: 10.h),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants().textColor,
                ),
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: loginController.emailController,
                title: 'Enter your email',
                icon: Icons.email_outlined,
              ),
              SizedBox(height: 10.h),
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants().textColor,
                ),
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                  controller: loginController.passwordController,
                  title: 'Enter your password',
                  icon: Icons.lock),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => ForgetPassword());
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants().textColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Obx(() {
                return loginController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : RoundButton(
                        title: 'Sign In',
                        onTap: () {
                          loginController.loginUser();
                        },
                        color: ColorConstants().buttonColor,
                        isloading: false,
                      );
              }),
              SizedBox(height: 50.h),
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: const Text(
                      'OR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.white)),
                ],
              ),
              SizedBox(height: 30.h),
              GoogleRoundButton(
                title: 'Sign In with Google',
                onTap: () {
                  final controller = Get.find<LoginController>();
                  controller.googleSignInUser();
                },
                color: Colors.white,
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorConstants().textColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignUp_Screen());
                    },
                    child: Text(
                      'Sign Up',
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
