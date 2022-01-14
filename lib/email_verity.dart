import 'package:email/login_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EmailVerfyPage extends StatelessWidget {
  EmailVerfyPage({Key? key}) : super(key: key);

  final _email = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이메일 인증'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 26,
            ),
            Text(
              _email,
            ),
            SizedBox(
              height: 36,
            ),
            Text(
              '위 이메일로 전송된 링크를 클릭하여\n이메일 인증을 완료하세요.',
            ),
            SizedBox(
              height: 50,
            ),
            Center(child: _makeBottomButton()),
          ],
        ),
      ),
    );
  }

  Widget _makeBottomButton() {
    return ElevatedButton(
      child: const Text(
        '로그인하러 가기',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      onPressed: () async {
        Get.off(LoginPage(), arguments: _email);
      },
    );
  }
}
