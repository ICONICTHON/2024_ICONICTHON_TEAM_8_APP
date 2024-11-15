class PersonalGetListItem {
  final int id;
  final String itemImage;
  final String itemType;
  final String lostTime;
  final String lostLocation;

  PersonalGetListItem({
    required this.id,
    required this.itemImage,
    required this.itemType,
    required this.lostTime,
    required this.lostLocation,
  });

  factory PersonalGetListItem.fromJson(Map<String, dynamic> json) {
    return PersonalGetListItem(
      id: json['id'],
      itemImage: json['itemImage'] ?? '',
      itemType: json['itemType'] ?? '',
      lostTime: json['lostTime'] ?? '',
      lostLocation: json['lostLocation'] ?? '',
    );
  }
}
