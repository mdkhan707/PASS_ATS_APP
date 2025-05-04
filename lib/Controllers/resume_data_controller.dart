import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:pass_ats/Models/certification_model.dart';
import 'package:pass_ats/Models/education_model.dart';
import 'package:pass_ats/Models/experience_model.dart';
import 'package:pass_ats/Models/project_model.dart';
import 'package:pass_ats/View/Screens/pdf_preview_screen.dart';
import 'package:pass_ats/constants/app_constants.dart';
import '../Models/personal_details_model.dart';

class ResumeDataController extends GetxController {
  /// Personal details
  final personal = PersonalDetailsModel().obs;

  // list of EducationModel
  final educationList = <EducationModel>[].obs;

  /// (Later) lists for education, experience, projects, certifications...
  // final education = <EducationModel>[].obs;
  // final experience = <ExperienceModel>[].obs;
  // ...

  /// Call this to update personal details en masse
  void updatePersonalDetails({
    String? name,
    String? phone,
    String? email,
    String? address,
    List<String>? links,
  }) {
    personal.update((p) {
      if (p == null) return;
      if (name != null) p.name = name;
      if (phone != null) p.phone = phone;
      if (email != null) p.email = email;
      if (address != null) p.address = address;
      if (links != null) p.links = links;
    });
  }

  void updateEducationList(List<EducationModel> newList) {
    educationList.assignAll(newList);
  }

  // Experience
  final experienceList = <ExperienceModel>[].obs;
  void updateExperienceList(List<ExperienceModel> newList) {
    experienceList.assignAll(newList);
  }

  /// Skills (just a list of strings)
  final skills = <String>[].obs;
  void updateSkills(List<String> newSkills) {
    skills.assignAll(newSkills);
  }

  /// **Job Description**
  final jobDescription = ''.obs;

  /// Call this to overwrite the stored job description
  void updateJobDescription(String description) {
    jobDescription.value = description;
  }

  final jobTitle = ''.obs;
  void updateJobTitle(String title) {
    jobTitle.value = title;
  }

  final projectList = <ProjectModel>[].obs;
  void updateProjectList(List<ProjectModel> newList) {
    projectList.assignAll(newList);
  }

  /// Languages
  final languages = <String>[].obs;
  void updateLanguages(List<String> newList) {
    languages.assignAll(newList);
  }

  /// Certifications
  final certificationList = <CertificationModel>[].obs;
  void updateCertificationList(List<CertificationModel> newList) {
    certificationList.assignAll(newList);
  }

  /// Soft Skills (just a list of strings)

  final softSkills = <String>[].obs;
  void updateSoftSkills(List<String> newList) {
    softSkills.assignAll(newList);
  }

  final isGenerating = false.obs;

  Future<void> generateResume() async {
    // 1) Validate presence of required data
    final missing = <String>[];
    if (personal.value.name.trim().isEmpty ||
        personal.value.phone.trim().isEmpty ||
        personal.value.email.trim().isEmpty) {
      missing.add('Personal details');
    }
    if (educationList.isEmpty) missing.add('Education');
    if (skills.isEmpty) missing.add('Skills');
    if (jobTitle.value.trim().isEmpty) missing.add('Job title');
    if (jobDescription.value.trim().isEmpty) missing.add('Job description');
    if (languages.isEmpty) missing.add('Languages');

    if (missing.isNotEmpty) {
      Get.snackbar(
        'Missing Data',
        'Please fill: ${missing.join(', ')}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // 2) Build request body
    final body = {
      'name': personal.value.name.trim(),
      'phone': personal.value.phone.trim(),
      'email': personal.value.email.trim(),
      'job_title': jobTitle.value.trim(),
      'links': personal.value.links,
      'education': educationList
          .map((e) => {
                'institution_name': e.institute,
                'major': e.fieldOfStudy,
                'duration': '${e.startDate} - ${e.endDate}',
              })
          .toList(),
      'experience': experienceList
          .map((e) => {
                'company_name': e.organization,
                'job_title': e.jobTitle,
                'duration': '${e.startDate} - ${e.endDate}',
                'responsibilities': [e.description],
              })
          .toList(),
      'projects': projectList
          .map((p) => {
                'project_name': p.projectName,
                'description': p.projectDescription,
              })
          .toList(),
      'skills': skills.toList(),
      'soft_skills': softSkills.toList(),
      'certifications': certificationList
          .map((c) => {
                'certification_name': c.title,
                'year': c.date,
              })
          .toList(),
      'languages': languages.toList(),
      'job_description': jobDescription.value.trim(),
    };
    print('this is the body: $body');

    isGenerating.value = true;
    try {
      final resp = await http.post(
        Uri.parse('${AppConstants.apiUrl}/api/generate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (resp.statusCode == 200) {
        final data = jsonDecode(resp.body);
        if (data['pdf'] != null) {
          final data = jsonDecode(resp.body);
          if (data['pdf'] != null) {
            final bytes = base64Decode(data['pdf'] as String);
            Get.to(() => PdfPreviewScreen(pdfData: bytes));
          }
        } else if (data['error'] != null) {
          Get.snackbar('Error', data['error'],
              snackPosition: SnackPosition.BOTTOM);
        } else {
          Get.snackbar('Error', 'Unexpected response from server',
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'Server error: ${resp.statusCode}',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print('This is the error: $e');
      Get.snackbar('Error', 'Failed to generate resume: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isGenerating.value = false;
    }
  }
}
