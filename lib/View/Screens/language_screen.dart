// lib/View/Screens/language_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pass_ats/Controllers/language_controller.dart';
import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // A separate controller from your skills
  final LanguageController langCtrl =
      Get.put(LanguageController(), permanent: true);
  final ResumeDataController resumeCtrl = Get.find<ResumeDataController>();

  @override
  void initState() {
    super.initState();
    // If we’ve saved languages before, prefill those
    if (resumeCtrl.languages.isNotEmpty) {
      // dispose any stray empty controllers
      for (var ctl in langCtrl.list) ctl.dispose();
      langCtrl.list.clear();
      // rebuild from saved data
      for (var lang in resumeCtrl.languages) {
        langCtrl.list.add(TextEditingController(text: lang));
      }
    }
    // Always start with at least one field
    if (langCtrl.list.isEmpty) {
      langCtrl.addField();
    }
  }

  void _onSave() {
    // must have ≥1
    if (langCtrl.list.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one language.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // no empty entries
    for (var i = 0; i < langCtrl.list.length; i++) {
      if (langCtrl.list[i].text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Fill in Language ${i + 1} or remove it.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }
    // persist
    final saved = langCtrl.list.map((ctl) => ctl.text.trim()).toList();
    resumeCtrl.updateLanguages(saved);
    Get.back();
  }

  @override
  void dispose() {
    // controllers will be cleaned up by LanguageController.onClose()
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
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                SizedBox(width: 10.w),
                Text(
                  'Languages',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // ← Dynamic list
            Obx(() {
              return Column(
                children: List.generate(langCtrl.list.length, (i) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: ResumeTextField(
                            label: 'Language ${i + 1}',
                            hint: 'e.g. English, Spanish',
                            controller: langCtrl.list[i],
                          ),
                        ),
                        IconButton(
                          onPressed: () => langCtrl.removeField(i),
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            }),

            SizedBox(height: 20.h),

            // ← Save & Add
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
                    onTap: langCtrl.addField,
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
