import 'package:flutter/material.dart';
import 'package:all_lof/models/lost_item.dart';
import 'package:all_lof/widgets/lost_item_card.dart';
import 'package:all_lof/widgets/lost_item_detail.dart';
import 'package:all_lof/data/dummy_data.dart';
import 'package:all_lof/widgets/custom_bottom_navigation_bar.dart';

void showLostItemDetail(BuildContext context, LostItem lostItem) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => LostItemDetail(lostItem: lostItem),
    ),
  );
}

class LostListPage extends StatefulWidget {
  const LostListPage({Key? key}) : super(key: key);

  @override
  State<LostListPage> createState() => _LostListPageState();
}

class _LostListPageState extends State<LostListPage> {
  int currentPage = 1;
  final int itemsPerPage = 5; // 한 페이지에 5개씩 고정

  List<LostItem> getPageItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return dummyLostItems.sublist(
      startIndex,
      endIndex.clamp(0, dummyLostItems.length),
    );
  }

  int get totalPages => (dummyLostItems.length / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '전체 분실물',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Handle notification button press
            },
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Colors.black,
              height: 1,
              thickness: 1,
            ),
          ),
          // 검색바
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
            child: Center(
              child: Container(
                width: double.infinity,
                height: 40,
                constraints: const BoxConstraints(maxWidth: 400),
                decoration: BoxDecoration(
                  color: Colors.grey[200]!,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
          ),

          // 리스트 - 한 페이지에 5개만 고정 표시
          Column(
            children: List.generate(
              getPageItems().length,
              (index) => LostItemCard(
                lostItem: getPageItems()[index],
                onTap: () {
                  showLostItemDetail(context, getPageItems()[index]);
                },
              ),
            ),
          ),
          const Spacer(),

          // 페이지네이션
          Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 왼쪽 화살표
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 12),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: currentPage > 1
                        ? () => setState(() => currentPage--)
                        : null,
                    color: currentPage > 1 ? Colors.black : Colors.grey,
                  ),

                  if (totalPages <= 5) ...[
                    // 페이지가 5 이하일 때 모든 페이지 표시
                    for (int i = 1; i <= totalPages; i++)
                      TextButton(
                        onPressed: () => setState(() => currentPage = i),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          minimumSize: const Size(20, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor:
                              currentPage == i ? Colors.red : Colors.black,
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: currentPage == i ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                  ] else if (currentPage <= 3) ...[
                    // 첫 3페이지 중 하나일 때 - 1 2 3 ... maxPage
                    for (int i = 1; i <= 3; i++)
                      TextButton(
                        onPressed: () => setState(() => currentPage = i),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          minimumSize: const Size(20, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor:
                              currentPage == i ? Colors.red : Colors.black,
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: currentPage == i ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                    const Text(
                      '...',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () => setState(() => currentPage = totalPages),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: const Size(20, 20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: Colors.black,
                      ),
                      child: Text(
                        '$totalPages',
                        style: const TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ] else if (currentPage >= totalPages - 2) ...[
                    // 마지막 3페이지 중 하나일 때 - 1 ... N-2 N-1 N
                    TextButton(
                      onPressed: () => setState(() => currentPage = 1),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: const Size(20, 20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Text(
                      '...',
                      style: TextStyle(fontSize: 15),
                    ),
                    for (int i = totalPages - 2; i <= totalPages; i++)
                      TextButton(
                        onPressed: () => setState(() => currentPage = i),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          minimumSize: const Size(20, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor:
                              currentPage == i ? Colors.red : Colors.black,
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: currentPage == i ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                  ] else ...[
                    // 중간 페이지일 때 - 1 ... currentPage-1 currentPage currentPage+1 ... maxPage
                    TextButton(
                      onPressed: () => setState(() => currentPage = 1),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: const Size(20, 20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Text(
                      '...',
                      style: TextStyle(fontSize: 15),
                    ),
                    for (int i = currentPage - 1; i <= currentPage + 1; i++)
                      TextButton(
                        onPressed: () => setState(() => currentPage = i),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          minimumSize: const Size(20, 20),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor:
                              currentPage == i ? Colors.red : Colors.black,
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            fontFamily: 'NotoSansKR',
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: currentPage == i ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                    const Text(
                      '...',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () => setState(() => currentPage = totalPages),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: const Size(20, 20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        foregroundColor: Colors.black,
                      ),
                      child: Text(
                        '$totalPages',
                        style: const TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],

                  // 오른쪽 화살표
                  IconButton(
                    icon: const Icon(Icons.arrow_forward, size: 12),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: currentPage < totalPages
                        ? () => setState(() => currentPage++)
                        : null,
                    color:
                        currentPage < totalPages ? Colors.black : Colors.grey,
                  ),
                ],
              )),

          // 하단 네비게이션 바
          CustomBottomNavigationBar(
            currentIndex: 1,
            onTap: (index) {
              // 네비게이션 로직 추가
            },
          ),
        ],
      ),
    );
  }
}
