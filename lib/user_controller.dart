import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'user_model.dart';

class UserController extends GetxController {
  var currentUserModel = UserModel().obs;

  @override
  Future<void> onInit() async {
    var auth = FirebaseAuth.instance;
    currentUserModel.value = await getUserModel(auth.currentUser!.uid);
    super.onInit();
  }

  Future<UserModel> getUserModel(String uid) async {
    UserModel userModel = UserModel();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot ds) {
      userModel = UserModel.fromSnapshot(ds);
    });
    return userModel;
  }
}
