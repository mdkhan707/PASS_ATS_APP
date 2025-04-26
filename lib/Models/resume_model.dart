class ResumeTemplate {
  final String id;
  final String name;
  final String pngUrl;
  final String pdfUrl;

  ResumeTemplate(
      {required this.id,
      required this.name,
      required this.pngUrl,
      required this.pdfUrl});

  factory ResumeTemplate.fromJson(Map<String, dynamic> json) {
    return ResumeTemplate(
      id: json["_id"],
      name: json["name"],
      pngUrl: json["pngUrl"],
      pdfUrl: json["pdfUrl"],
    );
  }
}
