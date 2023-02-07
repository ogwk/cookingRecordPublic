import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_record/const/custom_type.dart';
import 'package:cooking_record/unit/authentication_error.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final db = FirebaseFirestore.instance;

  Future<FirebaseAuthResultStatus> registerUser(
      String userName, String email, String password) async {
    // Firebaseにメール/パスワードでユーザー登録
    final FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseAuthResultStatus result;

    try {
      // ignore: unused_local_variable
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        result = FirebaseAuthResultStatus.successful;
      } else {
        result = FirebaseAuthResultStatus.undefined;
      }

      var collection = db.collection('user');
      await collection.doc(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'userName': userName,
        'email': email,
        'startDate': DateTime.now(),
        'imageUrl': "",
        'followUserIds ': [],
        'followerUserIds': [],
      });
    } on FirebaseAuthException catch (e) {
      // 登録に失敗した場合
      result = FirebaseAuthExceptionHandler.handleException(e);
    }
    return result;
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
}
