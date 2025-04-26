import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/Controllers/single_field_controller.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({super.key});

  final controller = Get.put(SingleFieldController());

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
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
                  'Projects',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Obx(() => Column(
                  children: List.generate(controller.list.length, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: ResumeTextField(
                              label: 'Projects ${index + 1}',
                              hint: 'e.g. Project Name',
                              controller: controller.list[index],
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.removeField(index),
                            icon: const Icon(Icons.delete_forever,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }),
                )),
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    title: "Save",
                    onTap: () {
                      for (var skill in controller.list) {
                        print("Skill: ${skill.text}");
                        // Save logic
                      }
                    },
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
            )
          ],
        ),
      ),
    );
  }
}
