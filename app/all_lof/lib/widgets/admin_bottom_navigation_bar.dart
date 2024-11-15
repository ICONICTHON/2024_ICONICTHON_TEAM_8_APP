import 'package:flutter/material.dart';
import 'package:all_lof/screens/notice_board_page.dart'; // 전체 게시판
import 'package:all_lof/screens/manager_page.dart'; // 관리자 페이지

class AdminBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const AdminBottomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NoticeBoardPage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ManagerPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // 네비게이션 바 전체 배경
        Container(
          height: kBottomNavigationBarHeight,
          color: const Color(0xFF4A423D),
        ),

        // 선택된 항목 표시용 진한 갈색 사각형
        Positioned(
          bottom: 0,
          left: MediaQuery.of(context).size.width / 2 * currentIndex,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: kBottomNavigationBarHeight,
            color: const Color(0xFF2B2522),
          ),
        ),

        // BottomNavigationBar 아이콘 및 텍스트
        BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), // 전체 게시판 아이콘
              label: '전체게시판',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), // 관리자 페이지 아이콘
              label: '관리자 페이지',
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
          onTap: (index) => _onItemTapped(context, index),
        ),
      ],
    );
  }
}
