import 'package:cooking_record/const/custom_type.dart';
import 'package:cooking_record/model/user.dart';
import 'package:cooking_record/repository/user_repository.dart';
import 'package:cooking_record/unit/authentication_error.dart';
import 'package:cooking_record/unit/firebase_auth_repository.dart';
import 'package:cooking_record/unit/shared_preference.dart';
import 'package:flutter/foundation.dart';

class MyPageViewModel {
  final ShareData shareData = ShareData();
  final UserRepository userRepository = UserRepository();
  User? user;
  bool isHideDisplayPassword = true;
  bool isHideDisplayOldPassword = true;
  bool isHideDisplayNewPassword = true;
  bool isHideDisplayNewPasswordRe = true;
  bool isLoginError = false;
  String errorMessage = "";

  MyPageViewModel() {
    shareData.setInstance().then((value) => getUserInfo());
  }

  Future<void> getUserInfo() async {
    user = User(
      id: shareData.getStringShareData("id"),
      email: shareData.getStringShareData("email"),
      userName: shareData.getStringShareData("userName"),
    );
  }

  Future<void> changeUserName(String changeUserName) async {
    setUserName = changeUserName;
    await userRepository.updateUserName(user!.id, changeUserName);
    shareData.setStringShareData('userName', changeUserName);
  }

  set setUserName(String changeUserName) {
    user = user?.copyWith(userName: changeUserName);
  }

  Future<void> login(String email, String password) async {
    final FirebaseAuthResultStatus signInResult =
        await FirebaseAuthRepository.singleton.login(email, password);

    if (signInResult != FirebaseAuthResultStatus.successful) {
      isLoginError = true;
      errorMessage =
          FirebaseAuthExceptionHandler.exceptionMessage(signInResult);
    }
  }

  Future<void> changeEmail(
      String oldEmail, String newEmail, String password) async {
    setEmail = newEmail;

    try {
      await FirebaseAuthRepository.singleton.changeEmail(newEmail);
      await userRepository.updateEmail(user!.id, newEmail);
      shareData.setStringShareData('email', newEmail);
    } catch (e) {
      if (kDebugMode) {
        print("changeEmail Error: ${e.toString()}");
      }
    }
  }

  Future<void> changePassword(
      String email, String oldPassword, String newPassword) async {
    try {
      await FirebaseAuthRepository.singleton.changePassword(newPassword);
    } catch (e) {
      if (kDebugMode) {
        print("changePassword Error: ${e.toString()}");
      }
    }
  }

  set setEmail(String changeEmail) {
    user = user?.copyWith(email: changeEmail);
  }
}
