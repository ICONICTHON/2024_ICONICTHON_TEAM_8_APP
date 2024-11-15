import 'package:all_lof/models/lost_item.dart';

final List<LostItem> dummyLostItems = List.generate(
  121,
  (index) => LostItem(
    id: index.toString(),
    name: '루이비통 카드 지갑',
    location: '정보문화관 P-402 안쪽',
    lostTime: "2024.11.11AM12.15",
    storageLocation: "정보문화관 P304",
    imageUrl: 'lib/assets/images/card2.jpg',
    reportedDate: DateTime(2024, 11, 11, 8),
  ),
);
