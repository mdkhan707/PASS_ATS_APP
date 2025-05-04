import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pass_ats/Controllers/soft_skills_controller.dart';
import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';

class SoftSkillsScreen extends StatefulWidget {
  const SoftSkillsScreen({Key? key}) : super(key: key);

  @override
  _SoftSkillsScreenState createState() => _SoftSkillsScreenState();
}

class _SoftSkillsScreenState extends State<SoftSkillsScreen> {
  final SoftSkillsController softCtrl =
      Get.put(SoftSkillsController(), permanent: true);
  final ResumeDataController resumeCtrl = Get.find<ResumeDataController>();

  @override
  void initState() {
    super.initState();
    // Prefill from saved data if present
    if (resumeCtrl.softSkills.isNotEmpty) {
      // clear any default
      for (var ctl in softCtrl.list) ctl.dispose();
      softCtrl.list.clear();
      // rebuild controllers from saved strings
      for (var skill in resumeCtrl.softSkills) {
        softCtrl.list.add(TextEditingController(text: skill));
      }
    }
    // ensure at least one field
    if (softCtrl.list.isEmpty) softCtrl.addField();
  }

  void _onSave() {
    // require ≥1
    if (softCtrl.list.isEmpty) {
      Get.snackbar(
        'Error',
        'Add at least one soft skill.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // no empty
    for (var i = 0; i < softCtrl.list.length; i++) {
      if (softCtrl.list[i].text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Fill in Soft Skill ${i + 1} or remove it.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }
    // persist
    resumeCtrl.updateSoftSkills(
      softCtrl.list.map((c) => c.text.trim()).toList(),
    );
    Get.back();
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
                  'Soft Skills',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // ← Dynamic list of fields
            Obx(() {
              return Column(
                children: List.generate(softCtrl.list.length, (i) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: ResumeTextField(
                            label: 'Soft Skill ${i + 1}',
                            hint: 'e.g. Communication, Teamwork',
                            controller: softCtrl.list[i],
                          ),
                        ),
                        IconButton(
                          onPressed: () => softCtrl.removeField(i),
                          icon: Icon(Icons.delete_forever, color: Colors.white),
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
                    onTap: softCtrl.addField,
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
