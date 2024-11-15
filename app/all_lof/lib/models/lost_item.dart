import 'dart:convert';

class LostItem {
  final String id;
  final String name;
  final String location;
  final String? lostTime;
  final String? storageLocation;
  final String? imageUrl;
  final DateTime reportedDate;

  LostItem({
    required this.id,
    required this.name,
    required this.location,
    this.lostTime,
    this.storageLocation,
    this.imageUrl,
    required this.reportedDate,
  });

  // fromJson 팩토리 생성자 추가
  factory LostItem.fromJson(Map<String, dynamic> json) {
    return LostItem(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      location: json['place'] ?? '',
      lostTime: json['lostTime'] ?? '',
      storageLocation: json['storageLocation'] ?? '',
      imageUrl: json['image'] ?? '',
      reportedDate: DateTime.parse(json['upload_date']),
    );
  }
}
