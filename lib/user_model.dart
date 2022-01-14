import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? displayName;
  String? email;
  String? userType;

  UserModel({
    this.uid,
    this.displayName,
    this.email,
    this.userType,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : userType = map['userType'],
        uid = map['uid'],
        displayName = map['displayName'],
        email = map['email'];

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : userType = snapshot['userType'],
        uid = snapshot['uid'],
        displayName = snapshot['displayName'],
        email = snapshot['email'];
}
