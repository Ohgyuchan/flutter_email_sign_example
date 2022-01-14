import 'package:email/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _signUpFormKey = GlobalKey<FormState>();

  final signUpController = Get.put(SignUpController());

  final TextEditingController _signUpEmailController = TextEditingController();
  final TextEditingController _signUpPasswordController =
      TextEditingController();
  final TextEditingController _signUpPasswordConfirmController =
      TextEditingController();
  final TextEditingController _signUpNickNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            '회원가입',
          ),
        ),
        body: _bodyWidget(),
      ),
    );
  }

  _bodyWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _signUpFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            emailField(),
            SizedBox(
              height: 10,
            ),
            passwordField(),
            SizedBox(
              height: 10,
            ),
            passwordConfirmField(),
            SizedBox(
              height: 10,
            ),
            nickNameField(),
            SizedBox(
              height: 48,
            ),
            _signUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return Obx(
      () => ElevatedButton(
        onPressed: () async {
          try {
            User? user;

            if (_signUpFormKey.currentState!.validate()) {
              signUpController.registering();
              user = await Authentication.signUpWithEmailAndPassword(
                _signUpEmailController.text,
                _signUpPasswordController.text,
                _signUpNickNameController.text,
              );

              if (user != null) {
                Get.offAllNamed(
                  '/login',
                  arguments: _signUpEmailController.text,
                );
                signUpController.notRegistering();
              } else {
                signUpController.notRegistering();
              }
            } else {
              Get.snackbar(
                "데이터 미입력",
                "데이터를 올바르게 입력하세요.🙁",
              );
            }
          } catch (e) {
            Get.snackbar(
              "Error",
              "$e",
            );
          }
        },
        child: Center(
          child: signUpController.isRegistering.value
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  '회원가입 완료하기',
                ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      controller: _signUpEmailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        hintText: "이메일 주소 입력",
        filled: true,
        fillColor: Colors.transparent,
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
        obscureText: !signUpController.visibility.value,
        controller: _signUpPasswordController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 16),
          hintText: "비밀번호 입력",
          filled: true,
          fillColor: Colors.transparent,
          suffixIcon: IconButton(
            onPressed: () {
              signUpController.visible();
            },
            icon: Icon(
              signUpController.visibility.value
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

  Widget passwordConfirmField() {
    return Obx(
      () => TextFormField(
        obscureText: !signUpController.visibilityCheck.value,
        controller: _signUpPasswordConfirmController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 16),
          hintText: "비밀번호 확인",
          filled: true,
          fillColor: Colors.transparent,
          suffixIcon: IconButton(
            onPressed: () {
              signUpController.visibleCheck();
            },
            icon: Icon(
              signUpController.visibilityCheck.value
                  ? Icons.visibility
                  : Icons.visibility_off,
            ),
          ),
        ),
        validator: (value) {
          if (value!.trim().isEmpty) {
            return '패스워드를 입력하세요.';
          } else if (value.trim() != _signUpPasswordController.text) {
            return '패스워드가 일치하지 않습니다.';
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget nickNameField() {
    return TextFormField(
      controller: _signUpNickNameController,
      maxLength: 10,
      style: const TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        hintText: "닉네임 입력",
        filled: true,
        fillColor: Colors.transparent,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return '닉네임을 입력하세요.';
        } else {
          return null;
        }
      },
    );
  }
}

class SignUpController extends GetxController {
  var visibility = false.obs;
  var visibilityCheck = false.obs;
  var isRegistering = false.obs;

  visible() {
    visibility.value ? visibility.value = false : visibility.value = true;
    update();
  }

  visibleCheck() {
    visibilityCheck.value
        ? visibilityCheck.value = false
        : visibilityCheck.value = true;
    update();
  }

  registering() {
    isRegistering.value = true;
    update();
  }

  notRegistering() {
    isRegistering.value = false;
    update();
  }
}
