import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/Controllers/login_controller.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart'; // your new widget

class ObjectiveScreen extends StatefulWidget {
  const ObjectiveScreen({Key? key}) : super(key: key);

  @override
  State<ObjectiveScreen> createState() => _ObjectiveScreenState();
}

class _ObjectiveScreenState extends State<ObjectiveScreen> {
  final loginController = Get.put(LoginController());

  final TextEditingController objectiveController = TextEditingController();

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
                    'Objectives',
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
                label: 'Objective',
                hint: 'Enter your objective',
                maxLines: 5,
                controller: objectiveController,
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
