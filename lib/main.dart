import 'package:email/email_verity.dart';
import 'package:email/home_page.dart';
import 'package:email/login_page.dart';
import 'package:email/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/login/signup',
          page: () => SignUpPage(),
        ),
        GetPage(
          name: '/login/signup/verify',
          page: () => EmailVerfyPage(),
        ),
        GetPage(
          name: '/login/home',
          page: () => HomePage(),
        ),
      ],
    );
  }
}
