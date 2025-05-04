// lib/View/Screens/certification_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/Models/certification_model.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';

class CertificationScreen extends StatefulWidget {
  const CertificationScreen({Key? key}) : super(key: key);

  @override
  _CertificationScreenState createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
  final ResumeDataController resumeCtrl =
      Get.put(ResumeDataController(), permanent: true);

  /// One map of controllers per certificate entry
  final List<Map<String, TextEditingController>> certCtls = [];

  @override
  void initState() {
    super.initState();
    // Prefill from any saved certifications
    for (var model in resumeCtrl.certificationList) {
      certCtls.add({
        'title': TextEditingController(text: model.title),
        'authority': TextEditingController(text: model.authority),
        'date': TextEditingController(text: model.date),
        'credentialId': TextEditingController(text: model.credentialId),
      });
    }
    // If none saved, start with one blank entry
    if (certCtls.isEmpty) {
      _addCertification();
    }
  }

  void _addCertification() {
    setState(() {
      certCtls.add({
        'title': TextEditingController(),
        'authority': TextEditingController(),
        'date': TextEditingController(),
        'credentialId': TextEditingController(),
      });
    });
  }

  void _removeCertification(int i) {
    setState(() {
      certCtls[i].forEach((_, ctl) => ctl.dispose());
      certCtls.removeAt(i);
    });
  }

  void _onSave() {
    // Must have at least one certificate
    if (certCtls.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one certification.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // All fields must be non-empty
    for (var i = 0; i < certCtls.length; i++) {
      final map = certCtls[i];
      if (map.values.any((ctl) => ctl.text.trim().isEmpty)) {
        Get.snackbar(
          'Error',
          'Please fill all fields for Certification ${i + 1}.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }

    // Build models and persist
    final newList = certCtls.map((map) {
      return CertificationModel(
        title: map['title']!.text.trim(),
        authority: map['authority']!.text.trim(),
        date: map['date']!.text.trim(),
        credentialId: map['credentialId']!.text.trim(),
      );
    }).toList();

    resumeCtrl.updateCertificationList(newList);
    Get.back();
  }

  @override
  void dispose() {
    for (var map in certCtls) {
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
                  'Certifications',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Dynamic certification entries
            ...List.generate(certCtls.length, (i) {
              final item = certCtls[i];
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
                            'Certification ${i + 1}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants().textColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeCertification(i),
                            icon:
                                Icon(Icons.delete_forever, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ResumeTextField(
                        label: 'Title',
                        hint: 'e.g. AWS Solutions Architect',
                        controller: item['title']!,
                      ),
                      ResumeTextField(
                        label: 'Issuing Authority',
                        hint: 'e.g. Amazon Web Services',
                        controller: item['authority']!,
                      ),
                      ResumeTextField(
                        label: 'Date (MM YYYY)',
                        hint: 'e.g. June 2023',
                        controller: item['date']!,
                      ),
                      ResumeTextField(
                        label: 'Credential ID',
                        hint: 'e.g. ABC-12345',
                        controller: item['credentialId']!,
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
                    onTap: _addCertification,
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
