// lib/View/Screens/education_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/Models/education_model.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  _EducationScreenState createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  /// Single shared controller for everything, lives until app shuts down
  final ResumeDataController resumeCtrl = Get.isRegistered()
      ? Get.find()
      : Get.put(ResumeDataController(), permanent: true);

  /// One map of TextEditingControllers per education entry
  final List<Map<String, TextEditingController>> eduCtls = [];

  @override
  void initState() {
    super.initState();
    // Prefill from any previously saved entries:
    for (var model in resumeCtrl.educationList) {
      eduCtls.add({
        'institute': TextEditingController(text: model.institute),
        'fieldOfStudy': TextEditingController(text: model.fieldOfStudy),
        'startDate': TextEditingController(text: model.startDate),
        'endDate': TextEditingController(text: model.endDate),
        'grade': TextEditingController(text: model.grade),
      });
    }
  }

  void _addEducation() {
    setState(() {
      eduCtls.add({
        'institute': TextEditingController(),
        'fieldOfStudy': TextEditingController(),
        'startDate': TextEditingController(),
        'endDate': TextEditingController(),
        'grade': TextEditingController(),
      });
    });
  }

  void _removeEducation(int i) {
    setState(() {
      // dispose each controller in that entry
      eduCtls[i].forEach((_, ctl) => ctl.dispose());
      eduCtls.removeAt(i);
    });
  }

  void _onSave() {
    // Must have at least one entry
    if (eduCtls.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one education entry',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // All fields of every entry must be non-empty
    for (var i = 0; i < eduCtls.length; i++) {
      final map = eduCtls[i];
      if (map.values.any((ctl) => ctl.text.trim().isEmpty)) {
        Get.snackbar(
          'Error',
          'Fill in every field for Education ${i + 1}',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }
    // Build-up models and persist
    final newList = eduCtls
        .map((map) => EducationModel(
              institute: map['institute']!.text.trim(),
              fieldOfStudy: map['fieldOfStudy']!.text.trim(),
              startDate: map['startDate']!.text.trim(),
              endDate: map['endDate']!.text.trim(),
              grade: map['grade']!.text.trim(),
            ))
        .toList();

    resumeCtrl.updateEducationList(newList);
    Get.back();
  }

  @override
  void dispose() {
    // clean up all controllers
    for (var map in eduCtls) {
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
            // ← Header
            Row(
              children: [
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Education',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // ← Dynamic list of editable blocks
            ...List.generate(eduCtls.length, (i) {
              final item = eduCtls[i];
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
                            'Education ${i + 1}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants().textColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeEducation(i),
                            icon:
                                Icon(Icons.delete_forever, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      // Fields
                      ResumeTextField(
                        label: 'Institute Name',
                        hint: 'eg. Harvard University',
                        controller: item['institute']!,
                      ),
                      ResumeTextField(
                        label: 'Field of Study',
                        hint: 'eg. Computer Science',
                        controller: item['fieldOfStudy']!,
                      ),
                      ResumeTextField(
                        label: 'Start Date',
                        hint: 'eg. Sep 2018',
                        controller: item['startDate']!,
                      ),
                      ResumeTextField(
                        label: 'End Date',
                        hint: 'eg. June 2022',
                        controller: item['endDate']!,
                      ),
                      ResumeTextField(
                        label: 'Grade',
                        hint: 'eg. 3.8 GPA',
                        controller: item['grade']!,
                      ),
                    ],
                  ),
                ),
              );
            }),

            // ← Save / Add row
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
                    onTap: _addEducation,
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
