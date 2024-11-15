import 'package:flutter/material.dart';
import 'package:all_lof/widgets/custom_bottom_navigation_bar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '분실물 종류',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 분실물 종류
            const Text(
              '분실물 종류',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CategoryIcon(label: '카드', icon: Icons.credit_card),
                CategoryIcon(label: '지갑', icon: Icons.account_balance_wallet),
                CategoryIcon(label: '우산', icon: Icons.umbrella),
                CategoryIcon(label: '기타', icon: Icons.add),
              ],
            ),
            const Divider(height: 32, thickness: 1),

            // 분실물 장소
            const Text(
              '분실물 장소',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                CategoryIcon(label: '정보문화관', icon: Icons.location_city),
                CategoryIcon(label: '신공학관', icon: Icons.location_city),
                CategoryIcon(label: '원흥관', icon: Icons.location_city),
                CategoryIcon(label: '기타', icon: Icons.add),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String label;
  final IconData icon;

  const CategoryIcon({Key? key, required this.label, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF4A423D),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(16),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
