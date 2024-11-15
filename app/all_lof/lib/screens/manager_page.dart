import 'package:all_lof/widgets/admin_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class ManagerPage extends StatelessWidget {
  const ManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CCTV 실시간 확인',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 분실물 장소 버튼들
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLocationButton(context, '정보문화관'),
                _buildLocationButton(context, '신공학관 3층'),
                _buildLocationButton(context, '신공학관 9층'),
                _buildLocationButton(context, '원흥관'),
                _buildLocationButton(context, '기타', isAdd: true),
              ],
            ),
            const SizedBox(height: 20),
            // 수취 확인 코드 영역
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  '수취 확인 코드 : abxd1234',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }

  Widget _buildLocationButton(BuildContext context, String title,
      {bool isAdd = false}) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF4A423D),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isAdd ? Icons.add : Icons.business,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
