import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pass_ats/Controllers/resume_data_controller.dart';

import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/Controllers/single_field_controller.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  _SkillsScreenState createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  // Make this permanent so its list of controllers (and their texts) survives pop/push
  final SingleFieldController controller = Get.isRegistered()
      ? Get.find<SingleFieldController>()
      : Get.put(SingleFieldController());
  final ResumeDataController resumeCtrl = Get.isRegistered()
      ? Get.find()
      : Get.put(ResumeDataController(), permanent: true);
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
                  'Skills',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // ← Dynamic list of skill fields
            Obx(() {
              return Column(
                children: List.generate(controller.list.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: ResumeTextField(
                            label: 'Skill ${index + 1}',
                            hint: 'e.g. Flutter, React',
                            controller: controller.list[index],
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.removeField(index),
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

            // ← Save & Add buttons
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
                    onTap: controller.addField,
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

  void _onSave() {
    // 1) Require at least one skill
    if (controller.list.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one skill.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 2) No empty skill fields
    if (controller.list.any((c) => c.text.trim().isEmpty)) {
      Get.snackbar(
        'Error',
        'Please fill in all skill fields or remove empty ones.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // All good → you can now persist controller.list.map((c)=>c.text).toList()
    // e.g. via your ResumeDataController or your existing save logic:
    //
    final skills = controller.list.map((c) => c.text.trim()).toList();
    resumeCtrl.updateSkills(skills);
    //
    Get.back();
  }
}
