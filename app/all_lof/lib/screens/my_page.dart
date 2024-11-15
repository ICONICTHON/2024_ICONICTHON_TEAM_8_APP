// lib/screens/my_page.dart

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:all_lof/widgets/custom_bottom_navigation_bar.dart';
import 'package:all_lof/models/user.dart';
import 'package:all_lof/models/personal_get_list_item.dart';
import 'package:all_lof/screens/login_page.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Dio _dio;
  User? _user;
  List<PersonalGetListItem> _receiptList = [];
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchReceiptList();
  }

  // 사용자 정보 가져오기
  Future<void> fetchUserInfo() async {
    try {
      final response = await _dio.get(
        '/information',
        options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        setState(() {
          _user = User.fromJson(response.data);
        });
      } else {
        setState(() {
          _hasError = true;
        });
        print('Failed to load user info: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      print('An error occurred while fetching user info: $e');
    }
  }

  // 수취 신청 내역 가져오기
  Future<void> fetchReceiptList() async {
    try {
      final response = await _dio.get(
        '/personal-get-list',
        options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          _receiptList =
              data.map((item) => PersonalGetListItem.fromJson(item)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        print('Failed to load receipt list: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print('An error occurred while fetching receipt list: $e');
    }
  }

  // 수취 확인 기능 구현
  Future<void> handleReceiptConfirmation(int receiptId) async {
    try {
      final response = await _dio.post(
        '/confirm-receipt',
        data: {'receiptId': receiptId},
        options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('수취 확인이 완료되었습니다.')),
        );
        setState(() {
          _receiptList.removeWhere((item) => item.id == receiptId);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('수취 확인 실패: ${response.data['message'] ?? '알 수 없는 오류'}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수취 확인 중 오류가 발생했습니다')),
      );
      print('수취 확인 오류: $e');
    }
  }

  // 로그아웃 기능 구현
  Future<void> _logout() async {
    try {
      final response = await _dio.post(
        '/logout',
        options: Options(
          contentType: Headers.jsonContentType,
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        // 로그아웃 성공 시 로그인 페이지로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('로그아웃 실패: ${response.data['message'] ?? '알 수 없는 오류'}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그아웃 중 오류가 발생했습니다')),
      );
      print('An error occurred during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '마이페이지',
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
              ? const Center(child: Text('사용자 정보를 불러오는 데 실패했습니다.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 사용자 정보 표시
                      Row(
                        children: [
                          _user!.userImage != null &&
                                  _user!.userImage!.isNotEmpty
                              ? CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      NetworkImage(_user!.userImage!),
                                )
                              : Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.person,
                                      size: 40, color: Colors.white),
                                ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _user!.name.isNotEmpty ? _user!.name : '이름',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(_user!.major.isNotEmpty
                                  ? _user!.major
                                  : '전공'),
                              Text(_user!.id.isNotEmpty ? _user!.id : '학번'),
                            ],
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: _logout,
                            child: const Text(
                              '로그아웃',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 1),
                      const SizedBox(height: 8),

                      // 수취 신청 내역 헤더
                      const Text(
                        '수취 신청 내역',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // 수취 신청 내역 리스트
                      Expanded(
                        child: _receiptList.isNotEmpty
                            ? ListView.builder(
                                itemCount: _receiptList.length,
                                itemBuilder: (context, index) {
                                  final receipt = _receiptList[index];
                                  return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        receipt.itemImage != null &&
                                                receipt.itemImage!.isNotEmpty
                                            ? Image.network(
                                                receipt.itemImage!,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                width: 50,
                                                height: 50,
                                                color: Colors.grey[300],
                                                child: const Icon(
                                                  Icons.image,
                                                  color: Colors.white,
                                                ),
                                              ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                receipt.itemType,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                receipt.lostTime,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                receipt.lostLocation,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFD04020),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          onPressed: () {
                                            // 수취 확인 로직 추가
                                            handleReceiptConfirmation(
                                                receipt.id);
                                          },
                                          child: const Text(
                                            '수취확인',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : const Center(child: Text('신청 내역이 없습니다.')),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        currentIndex: 2,
      ),
    );
  }
}
