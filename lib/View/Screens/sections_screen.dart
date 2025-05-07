import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';

class SectionScreen extends StatelessWidget {
  SectionScreen({super.key});
  final ResumeDataController resumeCtrl = Get.isRegistered()
      ? Get.find()
      : Get.put(ResumeDataController(), permanent: true);
  final List<Map<String, dynamic>> sectionItems = [
    {
      'icon': Icons.person,
      'label': 'Personal',
      'screen': const PersonalDetailScreen()
    },
    {
      'icon': Icons.school,
      'label': 'Education',
      'screen': const EducationScreen()
    },
    {
      'icon': Icons.work,
      'label': 'Experience',
      'screen': const ExperienceScreen()
    },
    {'icon': Icons.settings, 'label': 'Skill', 'screen': const SkillsScreen()},
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
      'screen': const ProjectScreen()
    },
    {
      'icon': Icons.language,
      'label': 'Languages',
      'screen': const LanguageScreen()
    },
    {
      'icon': Icons.emoji_events,
      'label': 'certifications',
      'screen': const CertificationScreen()
    },
    {
      'icon': Icons.self_improvement,
      'label': 'Soft Skills',
      'screen': const SoftSkillsScreen(),
    },
  ];

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
                      child: const Icon(Icons.arrow_back, color: Colors.white),
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
                    const Spacer(),
                    const Icon(Icons.help_outline, color: Colors.white),
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
                          ? () {
                              print('is loading value is true');
                              Get.snackbar(
                                'Generating Resume',
                                'Please wait while we generate your resume.',
                                backgroundColor: Colors.white,
                                colorText: Colors.black,
                                duration: const Duration(seconds: 2),
                              );
                              resumeCtrl.isGenerating.value = false;
                              return;
                            }
                          : () {
                              print('This function is called');
                              resumeCtrl.generateResume();
                            },
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
            physics: const NeverScrollableScrollPhysics(),
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
