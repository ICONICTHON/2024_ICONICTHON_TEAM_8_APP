import 'package:all_lof/screens/manager_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:all_lof/screens/lost_list_page.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Dio _dio; // Dio 인스턴스 선언
  final CookieJar _cookieJar = CookieJar(); // CookieJar 인스턴스 생성

  @override
  void initState() {
    super.initState();
    _dio = Dio();
    _dio.interceptors.add(CookieManager(_cookieJar));
  }

  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text; // 올바른 컨트롤러 사용

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('아이디와 비밀번호를 모두 입력해주세요.')),
      );
      return;
    }

    try {
      final response = await _dio.post(
        'https://all-laf.duckdns.org/process/login',
        data: {'id': username, 'password': password},
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        if (mounted) {
          if (username == "admin") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ManagerPage()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LostListPage()),
            );
          }
        }
      } else {
        if (mounted) {
          final errorMessage = response.data['message'] ?? '로그인 실패';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('로그인 실패: $errorMessage')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('로그인 중 오류가 발생했습니다')),
        );
      }
      print('로그인 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 위쪽 로고
            Image.asset(
              'assets/logos/logo-team.png',
              height: 80,
            ),
            const SizedBox(height: 40),

            // 사용자 ID 입력 필드
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ndrims ID(학번)을 입력해주세요.',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 비밀번호 입력 필드
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '비밀번호를 입력해주세요.',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 20),

            // 로그인 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD04020),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _login,
                child: const Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 하단 동국대학교 로고
            Image.asset(
              'assets/logos/logo-dongguk.png',
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
