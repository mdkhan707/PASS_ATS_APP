class EducationModel {
  String institute;
  String fieldOfStudy;
  String startDate;
  String endDate;
  String grade;

  EducationModel({
    this.institute = '',
    this.fieldOfStudy = '',
    this.startDate = '',
    this.endDate = '',
    this.grade = '',
  });

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'institute': institute,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate,
      'endDate': endDate,
      'grade': grade,
    };
  }

  // Create instance from JSON
  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      institute: json['institute'] ?? '',
      fieldOfStudy: json['fieldOfStudy'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      grade: json['grade'] ?? '',
    );
  }
}
