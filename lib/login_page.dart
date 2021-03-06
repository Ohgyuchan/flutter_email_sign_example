import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

enum Option { USER, ADMIN }

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final email = Get.arguments;
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _signInEmailController = TextEditingController();
  final TextEditingController _signInPasswordController =
      TextEditingController();
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('로그인'),
        ),
        body: _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
    if (email != null) {
      _signInEmailController.text = email;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _signInFormKey,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: Option.USER,
                            groupValue: loginController.option.value,
                            onChanged: (value) {
                              loginController.option.value = value as Option;
                            },
                          ),
                          Text('사용자'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: Option.ADMIN,
                            groupValue: loginController.option.value,
                            onChanged: (value) {
                              loginController.option.value = value as Option;
                            },
                          ),
                          Text('관리자'),
                        ],
                      ),
                    ],
                  ),
                ),
                emailField(),
                SizedBox(
                  height: 20,
                ),
                passwordField(),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Text(
                    '회원가입',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed('/login/signup');
                  },
                ),
              ],
            ),
            SizedBox(
              height: 88,
            ),
            _loginButton(),
            SizedBox(
              height: 33,
            ),
            const SizedBox(),
            const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return Obx(
      () => ElevatedButton(
        onPressed: () async {
          if (_signInFormKey.currentState!.validate()) {
            loginController.loging();
            _emailLogin();
          }
        },
        child: !loginController.isLoging.value
            ? const Text(
                '로그인',
              )
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }

  Future<void> _emailLogin() async {
    try {
      User? user = await Authentication.signInWithEmailAndPassword(
          _signInEmailController.text, _signInPasswordController.text);
      if (user != null) {
        if (loginController.option.value == Option.USER)
          Get.offNamed('/login/home');
        else
          Get.offNamed('/login/admin');
        // if (user.emailVerified) {
        //   Get.offNamed('/login/home');
        // } else {
        //   Get.snackbar(
        //     "이메일 인증 미확인",
        //     "인증 메일을 보냈습니다. 해당 이메일을 확인하세요.🙁",
        //   );
        //   await FirebaseAuth.instance.signOut();
        //   loginController.notLoging();
        // }
      } else {
        loginController.notLoging();
      }
    } catch (e) {
      loginController.notLoging();
      print('email login failed');
      print(e.toString());
    }
  }

  Widget emailField() {
    return TextFormField(
      controller: _signInEmailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        hintText: "이메일 주소 입력",
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '이메일을 입력하세요.';
        } else if (!value.isEmail) {
          return '이메일 형식이 아닙니다.';
        } else {
          return null;
        }
      },
    );
  }

  Widget passwordField() {
    return Obx(
      () => TextFormField(
        obscureText: !loginController.visibility.value,
        controller: _signInPasswordController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 16),
          hintText: "비밀번호 입력",
          suffixIcon: IconButton(
            onPressed: () {
              loginController.visible();
            },
            icon: Icon(
              loginController.visibility.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        ),
        validator: (value) {
          if (value!.trim().isEmpty) {
            return '패스워드를 입력하세요.';
          } else {
            return null;
          }
        },
      ),
    );
  }
}

class LoginController extends GetxController {
  var visibility = false.obs;
  var isLoging = false.obs;
  var option = Option.USER.obs;

  visible() {
    visibility.value ? visibility.value = false : visibility.value = true;
    update();
  }

  loging() {
    isLoging.value = true;
    update();
  }

  notLoging() {
    isLoging.value = false;
    update();
  }
}
