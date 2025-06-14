import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/View/Screens/SkillsScreen.dart';
import 'package:pass_ats/View/Screens/certification_screen.dart';
import 'package:pass_ats/View/Screens/education_screen.dart';
import 'package:pass_ats/View/Screens/experience_screen.dart';
import 'package:pass_ats/View/Screens/job_description.dart';
import 'package:pass_ats/View/Screens/language_screen.dart';
import 'package:pass_ats/View/Screens/objective_screen.dart';
import 'package:pass_ats/View/Screens/personal_details_screen.dart';
import 'package:pass_ats/View/Screens/project_screen.dart';
import 'package:pass_ats/View/Screens/soft_skills_screen.dart';
import 'package:pass_ats/View/Screens/pdf_preview_screen.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';

class SectionScreen extends StatelessWidget {
  final String templateId;
  SectionScreen({super.key, this.templateId = '684d63a26e2036897015de36'});
  final ResumeDataController resumeCtrl = Get.isRegistered()
      ? Get.find()
      : Get.put(ResumeDataController(), permanent: true);
  final List<Map<String, dynamic>> sectionItems = [
    {
      'icon': Icons.person,
      'label': 'Personal',
      'screen': const PersonalDetailScreen()
    },
    {'icon': Icons.school, 'label': 'Education', 'screen': EducationScreen()},
    {'icon': Icons.work, 'label': 'Experience', 'screen': ExperienceScreen()},
    {'icon': Icons.settings, 'label': 'Skill', 'screen': SkillsScreen()},
    {
      'icon': Icons.track_changes,
      'label': 'Objective',
      'screen': const ObjectiveScreen()
    },
    {
      'icon': Icons.description,
      'label': 'Job Description',
      'screen': const JobDescriptionScreen()
    },
  ];

  final List<Map<String, dynamic>> moreSectionItems = [
    {
      'icon': Icons.rocket_launch,
      'label': 'Projects',
      'screen': ProjectScreen()
    },
    {'icon': Icons.language, 'label': 'Languages', 'screen': LanguageScreen()},
    {
      'icon': Icons.emoji_events,
      'label': 'Certifications',
      'screen': CertificationScreen()
    },
    {
      'icon': Icons.self_improvement,
      'label': 'Soft Skills',
      'screen': const SoftSkillsScreen(),
    },
  ];

  void _generateResume() async {
    // Show Lottie animation overlay
    Get.dialog(
      Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animations/loading_resume2.json',
                width: 250.w,
                height: 250.h,
                fit: BoxFit.contain,
                repeat: true,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // Generate resume
    final pdfData = await resumeCtrl.generateResume(templateId);

    // Close animation dialog
    if (Get.isDialogOpen == true) {
      Get.back();
    }

    // Navigate to PdfPreviewScreen if successful
    if (pdfData != null) {
      Get.to(() => PdfPreviewScreen(pdfData: pdfData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Sections',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.help_outline, color: Colors.white),
                  ],
                ),
                SizedBox(height: 20.h),
                _sectionGroup(title: "Sections", items: sectionItems),
                SizedBox(height: 20.h),
                _sectionGroup(title: "More Sections", items: moreSectionItems),
                SizedBox(height: 20.h),
                Obx(() => RoundButton(
                      title: "Generate Resume",
                      onTap: resumeCtrl.isGenerating.value
                          ? () {} // Provide a no-op function while generating
                          : _generateResume,
                      color: ColorConstants().buttonColor,
                      isloading: resumeCtrl.isGenerating.value,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionGroup({
    required String title,
    required List<Map<String, dynamic>> items,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: ColorConstants().sectionColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          GridView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['screen'],
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item['icon'],
                          size: 30.sp, color: ColorConstants().primaryColor),
                      SizedBox(height: 6.h),
                      Text(
                        item['label'],
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorConstants().primaryColor,
                        ),
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
