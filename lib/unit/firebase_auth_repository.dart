import 'package:cooking_record/const/custom_type.dart';
import 'package:cooking_record/unit/authentication_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthRepository {
  static final FirebaseAuthRepository singleton =
      FirebaseAuthRepository._internal();
  FirebaseAuthRepository._internal();

  factory FirebaseAuthRepository() {
    return singleton;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<FirebaseAuthResultStatus> login(String email, String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseAuthResultStatus result;

    try {
      UserCredential? userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        result = FirebaseAuthResultStatus.successful;
      } else {
        result = FirebaseAuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      result = FirebaseAuthExceptionHandler.handleException(e);
    }
    return result;
  }

  Future<void> changeEmail(String newEmail) async {
    try {
      await auth.currentUser!.updateEmail(newEmail);
    } on FirebaseException {
      //エラー処理
      if (kDebugMode) {
        print("changeEmail Error");
      }
      return;
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await auth.currentUser!.updatePassword(newPassword);
    } on FirebaseException {
      //エラー処理
      if (kDebugMode) {
        print("changePassword Error");
      }
      return;
    }
  }
}
