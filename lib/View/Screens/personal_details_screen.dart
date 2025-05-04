// lib/View/Screens/personal_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pass_ats/Controllers/resume_data_controller.dart';
import 'package:pass_ats/View/Widgets/custom_round_button.dart';
import 'package:pass_ats/View/Widgets/gradient_scaffold.dart';
import 'package:pass_ats/constants/colors.dart';
import 'package:pass_ats/View/Widgets/custom_resume_text_field.dart';

class PersonalDetailScreen extends StatefulWidget {
  const PersonalDetailScreen({Key? key}) : super(key: key);

  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  // Make this controller permanent so its state survives pop/push
  final ResumeDataController resumeCtrl = Get.isRegistered()
      ? Get.find()
      : Get.put(ResumeDataController(), permanent: true);

  // Core text controllers
  final nameCtl = TextEditingController();
  final phoneCtl = TextEditingController();
  final emailCtl = TextEditingController();
  final addressCtl = TextEditingController();

  // One controller per link field
  final List<TextEditingController> linkCtls = [];

  @override
  void initState() {
    super.initState();
    // Pre-fill from controller (so saved data reappears on re-entry)
    final pd = resumeCtrl.personal.value;
    nameCtl.text = pd.name;
    phoneCtl.text = pd.phone;
    emailCtl.text = pd.email;
    addressCtl.text = pd.address;
    for (var link in pd.links) {
      linkCtls.add(TextEditingController(text: link));
    }
  }

  void _addLinkField() {
    setState(() => linkCtls.add(TextEditingController()));
  }

  void _removeLinkField(int i) {
    setState(() {
      linkCtls[i].dispose();
      linkCtls.removeAt(i);
    });
  }

  @override
  void dispose() {
    nameCtl.dispose();
    phoneCtl.dispose();
    emailCtl.dispose();
    addressCtl.dispose();
    for (var ctl in linkCtls) {
      ctl.dispose();
    }
    super.dispose();
  }

  void _onSave() {
    // 1. Validate core fields
    if ([nameCtl.text, phoneCtl.text, emailCtl.text, addressCtl.text]
        .any((t) => t.trim().isEmpty)) {
      Get.snackbar(
        'Error',
        'Please fill in all personal details',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 2. Validate link fields (if any exist)
    if (linkCtls.any((c) => c.text.trim().isEmpty)) {
      Get.snackbar(
        'Error',
        'Please fill in all link fields or remove empty ones',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 3. Passed validation → save and go back
    resumeCtrl.updatePersonalDetails(
      name: nameCtl.text.trim(),
      phone: phoneCtl.text.trim(),
      email: emailCtl.text.trim(),
      address: addressCtl.text.trim(),
      links: linkCtls.map((c) => c.text.trim()).toList(),
    );
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ← Back + Title
            Row(
              children: [
                InkWell(
                    onTap: () => Get.back(),
                    child: Icon(Icons.arrow_back, color: Colors.white)),
                SizedBox(width: 20.w),
                Text(
                  'Personal Details',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants().textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // ← Standard fields
            ResumeTextField(
              label: 'Name',
              hint: 'Enter your full name',
              controller: nameCtl,
            ),
            ResumeTextField(
              label: 'Phone Number',
              hint: 'Enter your phone number',
              controller: phoneCtl,
            ),
            ResumeTextField(
              label: 'Email',
              hint: 'Enter your email',
              controller: emailCtl,
            ),
            ResumeTextField(
              label: 'Address',
              hint: 'Enter your address',
              controller: addressCtl,
              maxLines: 3,
            ),

            SizedBox(height: 20.h),
            Text(
              'Links',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),

            // ← Dynamic list of link fields
            ...List.generate(linkCtls.length, (i) {
              return Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: ResumeTextField(
                        label: 'Link ${i + 1}',
                        hint: 'Enter URL or profile link',
                        controller: linkCtls[i],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    InkWell(
                      onTap: () => _removeLinkField(i),
                      child: Icon(Icons.remove_circle, color: Colors.red),
                    ),
                  ],
                ),
              );
            }),

            // ← Add a new empty link
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: _addLinkField,
                icon: Icon(Icons.add),
                label: Text('Add Link'),
              ),
            ),

            SizedBox(height: 30.h),

            // ← Save button with validation
            RoundButton(
              title: "Save",
              onTap: _onSave,
              color: ColorConstants().buttonColor,
              isloading: false,
            ),
          ],
        ),
      ),
    );
  }
}
