// lib/View/Screens/experience_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/Models/experience_model.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  _ExperienceScreenState createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final ResumeDataController resumeCtrl = Get.isRegistered()
      ? Get.find()
      : Get.put(ResumeDataController(), permanent: true);

  /// One map of controllers per experience entry
  final List<Map<String, TextEditingController>> expCtls = [];

  @override
  void initState() {
    super.initState();
    // Prefill from any saved experiences
    for (var model in resumeCtrl.experienceList) {
      expCtls.add({
        'jobTitle': TextEditingController(text: model.jobTitle),
        'organization': TextEditingController(text: model.organization),
        'startDate': TextEditingController(text: model.startDate),
        'endDate': TextEditingController(text: model.endDate),
        'description': TextEditingController(text: model.description),
      });
    }
  }

  void _addExperience() {
    setState(() {
      expCtls.add({
        'jobTitle': TextEditingController(),
        'organization': TextEditingController(),
        'startDate': TextEditingController(),
        'endDate': TextEditingController(),
        'description': TextEditingController(),
      });
    });
  }

  void _removeExperience(int i) {
    setState(() {
      expCtls[i].forEach((_, ctl) => ctl.dispose());
      expCtls.removeAt(i);
    });
  }

  void _onSave() {
    if (expCtls.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one experience entry',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    for (var i = 0; i < expCtls.length; i++) {
      if (expCtls[i].values.any((c) => c.text.trim().isEmpty)) {
        Get.snackbar(
          'Error',
          'Fill in every field for Experience ${i + 1}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    // Build models and save
    final newList = expCtls
        .map((map) => ExperienceModel(
              jobTitle: map['jobTitle']!.text.trim(),
              organization: map['organization']!.text.trim(),
              startDate: map['startDate']!.text.trim(),
              endDate: map['endDate']!.text.trim(),
              description: map['description']!.text.trim(),
            ))
        .toList();

    resumeCtrl.updateExperienceList(newList);
    Get.back();
  }

  @override
  void dispose() {
    for (var map in expCtls) {
      map.forEach((_, ctl) => ctl.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Experience',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Dynamic experience entries
            ...List.generate(expCtls.length, (i) {
              final item = expCtls[i];
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + delete
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Experience ${i + 1}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants().textColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeExperience(i),
                            icon:
                                Icon(Icons.delete_forever, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      // Fields
                      ResumeTextField(
                        label: 'Job Title',
                        hint: 'eg. Software Engineer',
                        controller: item['jobTitle']!,
                      ),
                      ResumeTextField(
                        label: 'Organization Name',
                        hint: 'eg. ABC Corp',
                        controller: item['organization']!,
                      ),
                      ResumeTextField(
                        label: 'Start Date',
                        hint: 'eg. Jan 2020',
                        controller: item['startDate']!,
                      ),
                      ResumeTextField(
                        label: 'End Date',
                        hint: 'eg. Dec 2022',
                        controller: item['endDate']!,
                      ),
                      ResumeTextField(
                        label: 'Description',
                        hint: 'Describe your role...',
                        controller: item['description']!,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 10.h),
            // Save & Add buttons
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    title: "Save",
                    onTap: _onSave,
                    color: ColorConstants().buttonColor,
                    isloading: false,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: RoundButton(
                    title: "Add",
                    onTap: _addExperience,
                    color: ColorConstants().buttonColor,
                    isloading: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
