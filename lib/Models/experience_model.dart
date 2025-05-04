// lib/Models/experience_model.dart
class ExperienceModel {
  String jobTitle;
  String organization;
  String startDate;
  String endDate;
  String description;

  ExperienceModel({
    this.jobTitle = '',
    this.organization = '',
    this.startDate = '',
    this.endDate = '',
    this.description = '',
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      jobTitle: json['jobTitle'] as String? ?? '',
      organization: json['organization'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'jobTitle': jobTitle,
        'organization': organization,
        'startDate': startDate,
        'endDate': endDate,
        'description': description,
      };
}
