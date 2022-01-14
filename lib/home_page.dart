import 'package:email/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userController.onInit(),
        builder: (context, snapshot) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: Text('사용자 홈'),
              actions: [
                IconButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Get.offNamed('/login');
                    },
                    icon: Icon(Icons.exit_to_app))
              ],
            ),
            body: snapshot.connectionState == ConnectionState.done
                ? Center(
                    child: Obx(() => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(userController.currentUserModel.value.uid
                                .toString()),
                            Text(userController.currentUserModel.value.email
                                .toString()),
                            Text(userController
                                .currentUserModel.value.displayName
                                .toString()),
                            Text(userController.currentUserModel.value.userType
                                .toString()),
                          ],
                        )),
                  )
                : Center(child: CircularProgressIndicator()),
          );
        });
  }
}
