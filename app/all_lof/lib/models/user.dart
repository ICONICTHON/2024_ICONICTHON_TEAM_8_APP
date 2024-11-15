// lib/models/user.dart

class User {
  final String userImage;
  final String name;
  final String major;
  final String id;

  User({
    required this.userImage,
    required this.name,
    required this.major,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userImage: json['userImage'] ?? '',
      name: json['name'] ?? '',
      major: json['major'] ?? '',
      id: json['id'] ?? '',
    );
  }
}
