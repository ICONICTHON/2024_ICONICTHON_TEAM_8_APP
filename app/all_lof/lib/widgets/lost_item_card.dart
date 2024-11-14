import 'package:flutter/material.dart';
import 'package:all_lof/models/lost_item.dart';
import 'package:intl/intl.dart';

class LostItemCard extends StatelessWidget {
  final LostItem lostItem;
  final VoidCallback onTap;

  const LostItemCard({
    Key? key,
    required this.lostItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 왼쪽 - 이미지 자리
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/card2.jpg'), // 카드 이미지 경로
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 25),
            // 오른쪽 - 내용
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  Text(
                    lostItem.name,
                    style: const TextStyle(
                      fontFamily: 'NotoSansKR', // 폰트 설정
                      fontSize: 16, // 이름의 폰트 크기
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 1),
                  // 날짜
                  Text(
                    DateFormat('  yyyy.MM.dd a h시')
                        .format(lostItem.reportedDate),
                    style: TextStyle(
                      fontFamily: 'NotoSansKR', // 폰트 설정
                      fontWeight: FontWeight.w500,
                      fontSize: 12, // 날짜의 폰트 크기
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // 위치
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.red[400],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          lostItem.location,
                          style: const TextStyle(
                            fontFamily: 'NotoSansKR', // 폰트 설정
                            fontSize: 12, // 위치의 폰트 크기
                            fontWeight: FontWeight.w700,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
