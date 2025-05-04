class PersonalDetailsModel {
  String name;
  String phone;
  String email;
  String address;
  List<String> links;

  PersonalDetailsModel({
    this.name = '',
    this.phone = '',
    this.email = '',
    this.address = '',
    List<String>? links,
  }) : links = links ?? [];

  // Convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'links': links,
    };
  }

  // Create instance from JSON
  factory PersonalDetailsModel.fromJson(Map<String, dynamic> json) {
    return PersonalDetailsModel(
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      links: List<String>.from(json['links'] ?? []),
    );
  }
}
