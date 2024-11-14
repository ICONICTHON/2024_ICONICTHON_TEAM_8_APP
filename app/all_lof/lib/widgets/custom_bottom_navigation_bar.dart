import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // 네비게이션 바 전체 배경 (연한 갈색)
        Container(
          height: kBottomNavigationBarHeight,
          color: const Color(0xFF4A423D), // 연한 갈색
        ),

        // 선택된 항목 표시용 진한 갈색 사각형
        Positioned(
          bottom: 0,
          left: MediaQuery.of(context).size.width / 3 * currentIndex,
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: kBottomNavigationBarHeight,
            color: const Color(0xFF2B2522), // 진한 갈색
          ),
        ),

        // BottomNavigationBar 아이콘 및 텍스트
        BottomNavigationBar(
          backgroundColor: Colors.transparent, // 기본 배경을 투명하게 설정
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/icon-main.png'),
                size: 24,
              ),
              label: '메인',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/icon-category.png'),
                size: 24,
              ),
              label: '카테고리 선택',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/icon-mypage.png'),
                size: 24,
              ),
              label: '마이페이지',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
