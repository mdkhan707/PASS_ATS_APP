// lib/View/Screens/job_description_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';

class JobDescriptionScreen extends StatefulWidget {
  const JobDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<JobDescriptionScreen> createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
  final ResumeDataController resumeCtrl =
      Get.put(ResumeDataController(), permanent: true);

  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController descriptionCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Prefill with any previously saved values
    titleCtl.text = resumeCtrl.jobTitle.value;
    descriptionCtl.text = resumeCtrl.jobDescription.value;
  }

  @override
  void dispose() {
    titleCtl.dispose();
    descriptionCtl.dispose();
    super.dispose();
  }

  void _onSave() {
    final title = titleCtl.text.trim();
    final desc = descriptionCtl.text.trim();

    // Validation: require both fields
    if (title.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a job title.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (desc.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a job description.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Save into controller
    resumeCtrl.updateJobTitle(title);
    resumeCtrl.updateJobDescription(desc);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ← Header
            Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(width: 20.w),
                Text(
                  'Job Description',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // ← Job Title field
            ResumeTextField(
              label: 'Job Title',
              hint: 'e.g. Senior Flutter Developer',
              controller: titleCtl,
            ),
            SizedBox(height: 20.h),

            // ← Multi-line description
            ResumeTextField(
              label: 'Job Description',
              hint: 'Enter your job description',
              maxLines: 10,
              controller: descriptionCtl,
            ),

            SizedBox(height: 20.h),
            RoundButton(
              title: "Save",
              onTap: _onSave,
              color: ColorConstants().buttonColor,
              isloading: false,
            ),
          ],
        ),
      ),
    );
  }
}
