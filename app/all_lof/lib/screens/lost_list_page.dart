import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:all_lof/models/lost_item.dart';
import 'package:all_lof/widgets/lost_item_card.dart';
import 'package:all_lof/widgets/lost_item_detail.dart';
import 'package:http/http.dart' as http;
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
  final int itemsPerPage = 5; // Fixed to 5 items per page
  List<LostItem> lostItems = [];
  bool isLoading = true; // To manage loading state
  bool hasError = false; // To manage error state

  @override
  void initState() {
    super.initState();
    fetchLostItems();
  }

  Future<void> fetchLostItems() async {
    try {
      final response = await http
          .get(Uri.parse('https://all-laf.duckdns.org/lost-item-list'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          lostItems = jsonData.map((item) => LostItem.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        // Handle error
        setState(() {
          isLoading = false;
          hasError = true;
        });
        print('Failed to load data');
      }
    } catch (e) {
      // Handle exceptions
      setState(() {
        isLoading = false;
        hasError = true;
      });
      print('An error occurred: $e');
    }
  }

  List<LostItem> getPageItems() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, lostItems.length);
    return lostItems.sublist(
      startIndex,
      endIndex,
    );
  }

  int get totalPages => (lostItems.length / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading indicator while fetching data
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (hasError) {
      // Show error message if data fetching failed
      return Scaffold(
        appBar: _buildAppBar(),
        body: Center(child: Text('Failed to load data')),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
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
          // Search bar
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
          // List - display 5 items per page
          Expanded(
            child: ListView(
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
          ),
          _buildPagination(),
          const CustomBottomNavigationBar(
            currentIndex: 0,
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildPagination() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left arrow
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 12),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed:
                currentPage > 1 ? () => setState(() => currentPage--) : null,
            color: currentPage > 1 ? Colors.black : Colors.grey,
          ),
          ..._buildPageNumbers(),
          // Right arrow
          IconButton(
            icon: const Icon(Icons.arrow_forward, size: 12),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: currentPage < totalPages
                ? () => setState(() => currentPage++)
                : null,
            color: currentPage < totalPages ? Colors.black : Colors.grey,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageNumbers() {
    List<Widget> pageNumbers = [];

    if (totalPages <= 5) {
      // Display all page numbers if total pages <= 5
      for (int i = 1; i <= totalPages; i++) {
        pageNumbers.add(_buildPageNumberButton(i));
      }
    } else if (currentPage <= 3) {
      // If current page is among the first 3
      for (int i = 1; i <= 3; i++) {
        pageNumbers.add(_buildPageNumberButton(i));
      }
      pageNumbers.add(const Text('...', style: TextStyle(fontSize: 15)));
      pageNumbers.add(_buildPageNumberButton(totalPages));
    } else if (currentPage >= totalPages - 2) {
      // If current page is among the last 3
      pageNumbers.add(_buildPageNumberButton(1));
      pageNumbers.add(const Text('...', style: TextStyle(fontSize: 15)));
      for (int i = totalPages - 2; i <= totalPages; i++) {
        pageNumbers.add(_buildPageNumberButton(i));
      }
    } else {
      // If current page is in the middle
      pageNumbers.add(_buildPageNumberButton(1));
      pageNumbers.add(const Text('...', style: TextStyle(fontSize: 15)));
      for (int i = currentPage - 1; i <= currentPage + 1; i++) {
        pageNumbers.add(_buildPageNumberButton(i));
      }
      pageNumbers.add(const Text('...', style: TextStyle(fontSize: 15)));
      pageNumbers.add(_buildPageNumberButton(totalPages));
    }

    return pageNumbers;
  }

  Widget _buildPageNumberButton(int pageNumber) {
    return TextButton(
      onPressed: () => setState(() => currentPage = pageNumber),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size(20, 20),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: currentPage == pageNumber ? Colors.red : Colors.black,
      ),
      child: Text(
        '$pageNumber',
        style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w700,
          fontSize: 15,
          color: currentPage == pageNumber ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}
