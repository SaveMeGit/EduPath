// User Model: lib/models/user_model.dart

class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String language;
  final String? grade;
  final String accountType;
  final String linkCode;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.language,
    this.grade,
    required this.accountType,
    required this.linkCode,
    required this.createdAt,
  });

  UserModel copyWith({
    String? name,
    String? language,
    String? grade,
    String? accountType,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      phoneNumber: phoneNumber,
      language: language ?? this.language,
      grade: grade ?? this.grade,
      accountType: accountType ?? this.accountType,
      linkCode: linkCode,
      createdAt: createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      language: json['language'],
      grade: json['grade'],
      accountType: json['accountType'],
      linkCode: json['linkCode'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'language': language,
      'grade': grade,
      'accountType': accountType,
      'linkCode': linkCode,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

