import 'package:flutter/material.dart';
import 'package:all_lof/models/lost_item.dart';
import 'package:intl/intl.dart';
import 'package:all_lof/widgets/admin_bottom_navigation_bar.dart';

class AdminLostItemDetail extends StatelessWidget {
  final LostItem lostItem;

  const AdminLostItemDetail({
    Key? key,
    required this.lostItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color arrowColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/card2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 8,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: arrowColor, size: 18),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lostItem.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '분실 시간: ${DateFormat('yyyy.MM.dd a h시').format(lostItem.reportedDate)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '분실 장소: ${lostItem.location}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '보관 장소: ${lostItem.storageLocation}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        '지도 이미지',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // 하단 버튼들
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // 수정 버튼 눌렀을 때 로직
                            },
                            child: const Text(
                              '수정',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.grey),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              // 삭제 버튼 눌렀을 때 로직
                            },
                            child: const Text(
                              '삭제',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AdminBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }
}
