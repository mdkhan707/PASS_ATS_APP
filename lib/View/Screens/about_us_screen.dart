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
              'At PassATS, we help you create professional, ATS-friendly resumes with ease. Our app uses AI-powered by Llama-2 to generate tailored resumes based on your details and job descriptions, ensuring your resume passes Applicant Tracking Systems used by recruiters.',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: ColorConstants().textColor,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Why Choose PassATS?',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorConstants().textColor,
              ),
            ),
            SizedBox(height: 8.h),
            bulletPoint(
                'ATS-Optimized: Every resume is designed to pass ATS with relevant keywords and proper formatting.'),
            bulletPoint(
                'Tailored for Jobs: Input your experience and job description, and we customize your resume accordingly.'),
            bulletPoint(
                'Fast & Simple: Use pre-designed templates to quickly create polished resumes.'),
            bulletPoint(
                'Secure Data: Your data is safely stored in Firebase, accessible anytime.'),
            SizedBox(height: 20.h),
            RoundButton(
                title: 'Generate a resume with us',
                onTap: () {
                  Get.to(() => SectionScreen());
                },
                color: ColorConstants().buttonColor,
                isloading: false)
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
