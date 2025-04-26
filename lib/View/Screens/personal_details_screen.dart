import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/login_controller.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart'; // your new widget

class Personal_Detail_screen extends StatefulWidget {
  const Personal_Detail_screen({Key? key}) : super(key: key);

  @override
  State<Personal_Detail_screen> createState() => _Personal_Detail_screenState();
}

class _Personal_Detail_screenState extends State<Personal_Detail_screen> {
  final loginController = Get.put(LoginController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  SizedBox(width: 20.w),
                  Text(
                    'Personal Details',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants().textColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              ResumeTextField(
                label: 'Name',
                hint: 'Enter your full name',
                controller: nameController,
              ),
              ResumeTextField(
                label: 'Phone Number',
                hint: 'Enter your phone number',
                controller: phoneController,
              ),
              ResumeTextField(
                label: 'Email',
                hint: 'Enter your email address',
                controller: emailController,
              ),
              ResumeTextField(
                label: 'Address',
                hint: 'Enter your address',
                controller: addressController,
                maxLines: 3,
              ),
              SizedBox(height: 20.h),
              RoundButton(
                  title: "Save",
                  onTap: () {},
                  color: ColorConstants().buttonColor,
                  isloading: false)
            ],
          ),
        ),
      ),
    );
  }
}
