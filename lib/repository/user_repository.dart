import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_record/model/user.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  final db = FirebaseFirestore.instance;

  Future<User?> getUserinfo(String userId) async {
    User getUser;
    final docRef = db.collection("user").doc(userId);

    final res = await docRef.get();
    if (res.exists == false) return null;

    Map<String, dynamic> itemMap = res.data()!;
    itemMap["id"] = res.id;
    itemMap["startDate"] =
        ((res["startDate"] as Timestamp).toDate().toString());

    getUser = User.fromJson(itemMap);
    return getUser;
  }

  Future<void> updateUserName(String userId, String userName) async {
    try {
      final docRef = db.collection("user").doc(userId);
      await docRef.update({
        'userName': userName,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> updateEmail(String userId, String email) async {
    try {
      final docRef = db.collection("user").doc(userId);
      await docRef.update({
        'email': email,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
