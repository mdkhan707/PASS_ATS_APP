import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/View/Screens/sections_screen.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 100.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Us',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorConstants().textColor,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'PassATS is a mobile application designed to assist job seekers in creating Applicant Tracking System (ATS)-compliant resumes using LLaMA 3.3, an open-source large language model.',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants().textColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorConstants().textColor,
              ),
            ),
            SizedBox(height: 8.h),
            bulletPoint(
                'Solves the problem of resumes being filtered out by automated systems.'),
            bulletPoint(
                'Accessible, customizable, and privacy-focused resume generation.'),
            bulletPoint(
                'Templates are based on successful resumes from companies like Google and Facebook.'),
            bulletPoint('Ensures ATS compatibility using best practices.'),
            bulletPoint(
                'Powered by Groq Cloud for efficient, cost-free AI resume generation.'),
            bulletPoint(
                'Targets graduates, freelancers, and underserved communities.'),
            SizedBox(height: 20.h),
            RoundButton(
              title: 'Generate a resume with us',
              onTap: () {
                Get.to(() => SectionScreen());
              },
              color: ColorConstants().buttonColor,
              isloading: false,
            )
          ],
        ),
      ),
    );
  }

  Widget bulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ',
              style: TextStyle(
                  fontSize: 16.sp, color: ColorConstants().textColor)),
          Expanded(
            child: Text(
              text,
              style:
                  TextStyle(fontSize: 14.sp, color: ColorConstants().textColor),
            ),
          ),
        ],
      ),
    );
  }
}
