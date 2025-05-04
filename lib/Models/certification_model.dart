// lib/Models/certification_model.dart
class CertificationModel {
  String title;
  String authority;
  String date; // e.g. “June 2023”
  String credentialId; // e.g. “ABC-1234”

  CertificationModel({
    this.title = '',
    this.authority = '',
    this.date = '',
    this.credentialId = '',
  });

  factory CertificationModel.fromJson(Map<String, dynamic> json) {
    return CertificationModel(
      title: json['title'] as String? ?? '',
      authority: json['authority'] as String? ?? '',
      date: json['date'] as String? ?? '',
      credentialId: json['credentialId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'authority': authority,
        'date': date,
        'credentialId': credentialId,
      };
}
