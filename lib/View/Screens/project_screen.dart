// lib/View/Screens/project_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/Models/project_model.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/constants/colors.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  // Use the permanent ResumeDataController so state sticks
  final ResumeDataController resumeCtrl =
      Get.put(ResumeDataController(), permanent: true);

  /// One map of controllers per project entry
  final List<Map<String, TextEditingController>> projectCtls = [];

  @override
  void initState() {
    super.initState();
    // Prefill from any saved projects
    for (var model in resumeCtrl.projectList) {
      projectCtls.add({
        'name': TextEditingController(text: model.projectName),
        'description': TextEditingController(text: model.projectDescription),
      });
    }
    // If no saved entries, start with one blank
    if (projectCtls.isEmpty) {
      _addProject();
    }
  }

  void _addProject() {
    setState(() {
      projectCtls.add({
        'name': TextEditingController(),
        'description': TextEditingController(),
      });
    });
  }

  void _removeProject(int i) {
    setState(() {
      projectCtls[i].forEach((_, ctl) => ctl.dispose());
      projectCtls.removeAt(i);
    });
  }

  void _onSave() {
    // Must have at least one project
    if (projectCtls.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add at least one project.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    // Neither name nor description may be empty
    for (var i = 0; i < projectCtls.length; i++) {
      final map = projectCtls[i];
      if (map['name']!.text.trim().isEmpty ||
          map['description']!.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Please fill in both fields for Project ${i + 1}.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
    }
    // Build models and persist
    final newList = projectCtls.map((map) {
      return ProjectModel(
        projectName: map['name']!.text.trim(),
        projectDescription: map['description']!.text.trim(),
      );
    }).toList();

    resumeCtrl.updateProjectList(newList);
    Get.back();
  }

  @override
  void dispose() {
    for (var map in projectCtls) {
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

            // ← Dynamic list of project entries
            ...List.generate(projectCtls.length, (i) {
              final item = projectCtls[i];
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
                            'Project ${i + 1}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorConstants().textColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _removeProject(i),
                            icon: const Icon(Icons.delete_forever,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      // Name field
                      ResumeTextField(
                        label: 'Project Name',
                        hint: 'e.g. My Awesome App',
                        controller: item['name']!,
                      ),
                      SizedBox(height: 10.h),
                      // Description field
                      ResumeTextField(
                        label: 'Description',
                        hint: 'Describe what it does...',
                        controller: item['description']!,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 10.h),
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
                    onTap: _addProject,
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
