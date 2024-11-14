import 'package:flutter/material.dart';
import 'package:all_lof/models/lost_item.dart';
import 'package:intl/intl.dart';
import 'custom_bottom_navigation_bar.dart';

class LostItemDetail extends StatelessWidget {
  final LostItem lostItem;

  const LostItemDetail({Key? key, required this.lostItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 현재 테마가 밝은지 어두운지에 따라 화살표 색상 결정
    Color arrowColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          // 이미지가 상단에 꽉 차게 설정
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              height: 300, // 이미지 높이 조정
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/card2.jpg'), // 카드 이미지 경로
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // 상단의 뒤로 가기 화살표 아이콘
          Positioned(
            top: 50, // 상단 여백 조정
            left: 8,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: arrowColor, size: 18),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // 본문 내용
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 이름
                  Text(
                    lostItem.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 분실 시간
                  Text(
                    '분실 시간: ${DateFormat('yyyy.MM.dd a h시').format(lostItem.reportedDate)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 분실 장소
                  Text(
                    '분실 장소: ${lostItem.location}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 보관 장소
                  Text(
                    '보관 장소: ${lostItem.location} 옆 관리실',
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 35),
                  // 지도 이미지
                  Container(
                    height: 170,
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
                  const SizedBox(height: 16),
                  // 수취 신청 버튼
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD04020),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        // 수취 신청 로직 추가
                      },
                      child: const Text(
                        '수취 신청',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          // 하단 네비게이션 바 아이템 선택 시 동작 처리
        },
      ),
    );
  }
}
