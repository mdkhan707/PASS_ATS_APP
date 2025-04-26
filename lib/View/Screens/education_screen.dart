import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/Controllers/education_controller.dart';

class EducationScreen extends StatelessWidget {
  EducationScreen({super.key});

  final controller = Get.put(EducationController());

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
                  child: const Icon(Icons.arrow_back, color: Colors.white),
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

            // Education Fields
            Obx(() => Column(
                  children:
                      List.generate(controller.educationList.length, (index) {
                    final item = controller.educationList[index];
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
                            // Title and Delete
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Education ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants().textColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      controller.removeEducation(index),
                                  icon: const Icon(Icons.delete_forever,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            ResumeTextField(
                              label: 'Institute Name',
                              hint: 'eg. Harvard University',
                              controller: item['institute']!,
                            ),
                            ResumeTextField(
                              label: 'Field of Study',
                              hint: 'eg. Computer Science',
                              controller: item['field']!,
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
                )),

            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    title: "Save",
                    onTap: () {
                      for (var edu in controller.educationList) {
                        print("Institute: ${edu['institute']?.text}");
                        // Save logic here
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
                    onTap: controller.addEducation,
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
