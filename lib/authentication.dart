import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  static Future<User?> signUpWithEmailAndPassword(
      String email, String password, String nickName, type) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          "uid": user.uid,
          "displayName": nickName,
          "email": email,
          "type": type,
        });
        return user;
      }

      return user;
    } catch (e) {
      if (e.toString() ==
          '[firebase_auth/weak-password] Password should be at least 6 characters') {
        Get.snackbar(
          "비밀번호가 너무 짧습니다.",
          "6자 이상으로 설정해주세요.🙁",
        );
      } else {
        Get.snackbar(
          "중복 이메일",
          "이미 사용중인 이메일입니다.🙁",
        );
      }
      print('sign up failed');
    }
  }

  static Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    final auth = FirebaseAuth.instance;

    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      // if (user != null && !user.emailVerified) {
      //   user.sendEmailVerification();
      //   await FirebaseAuth.instance.signOut();
      // }

      return user;
    } on PlatformException catch (e) {
      print(e.toString());
    } catch (e) {
      print('sign in failed');
      if (Platform.isAndroid) {
        switch (e.toString()) {
          case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
            Get.snackbar(
              "존재하지 않는 이메일 입니다.",
              "회원가입을 먼저 해주세요.🙁",
            );
            break;
          case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
            Get.snackbar(
              "패스워드가 틀렸습니다.",
              "패스워드를 확인 해주세요.🙁c",
            );
            break;
          case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
            Get.snackbar(
              "네트워크 오류",
              "와이파이 혹은 모바일 데이터를 먼저 켜주세요.🙁",
            );
            break;
          default:
            Get.snackbar(
              "Error",
              "$e",
            );
        }
      }
    }
  }
}
