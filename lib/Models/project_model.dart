// lib/Models/project_model.dart
class ProjectModel {
  String projectName;
  String projectDescription;

  ProjectModel({
    this.projectName = '',
    this.projectDescription = '',
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectName: json['projectName'] as String? ?? '',
      projectDescription: json['projectDescription'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'projectName': projectName,
        'projectDescription': projectDescription,
      };
}
