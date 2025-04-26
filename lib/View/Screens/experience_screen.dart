import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/Controllers/experience_controller.dart'; // NEW

class ExperienceScreen extends StatelessWidget {
  ExperienceScreen({Key? key}) : super(key: key);

  final ExperienceController controller = Get.put(ExperienceController());

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

            // Experience Form List
            Obx(() => Column(
                  children:
                      List.generate(controller.experiences.length, (index) {
                    final item = controller.experiences[index];
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
                                  'Experience ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstants().textColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      controller.removeExperience(index),
                                  icon: const Icon(Icons.delete_forever,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
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
                )),

            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: RoundButton(
                    title: "Save",
                    onTap: () {
                      for (var exp in controller.experiences) {
                        print("Title: ${exp['jobTitle']?.text}");
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
                    onTap: controller.addExperience,
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
