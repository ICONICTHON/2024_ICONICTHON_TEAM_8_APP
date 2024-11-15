import 'package:all_lof/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:all_lof/screens/lost_list_page.dart';
import 'package:all_lof/screens/category_page.dart';
import 'package:all_lof/screens/my_page.dart';
import 'package:all_lof/screens/notice_board_page.dart'; // 관리자용 페이지
import 'package:all_lof/screens/manager_page.dart'; // 관리자용 페이지
import 'package:all_lof/widgets/custom_bottom_navigation_bar.dart';
import 'package:all_lof/widgets/admin_bottom_navigation_bar.dart'; // 관리자용 네비게이션 바

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const LostListPage(),
    const CategoryPage(),
    const MyPage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
      ),
    );
  }
}

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _currentIndex = 0;

  final List<Widget> _adminPages = [
    const NoticeBoardPage(),
    const ManagerPage(),
  ];

  void _onAdminTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _adminPages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _adminPages[_currentIndex],
      bottomNavigationBar: AdminBottomNavigationBar(
        currentIndex: _currentIndex,
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lost and Found',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        splashFactory: NoSplash.splashFactory,
      ),
      home: const LoginPage(),
    );
  }
}
