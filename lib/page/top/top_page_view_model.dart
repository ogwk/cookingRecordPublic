import 'package:cooking_record/model/user.dart';
import 'package:cooking_record/repository/user_repository.dart';
import 'package:cooking_record/unit/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class TopPageViewModel {
  final UserRepository userRepository = UserRepository();
  User? user;
  String? sharedText;
  final ShareData shareData = ShareData();
  final userId = FirebaseAuth.instance.currentUser?.uid ?? "";

  Future<void> getUserInfo() async {
    user = await userRepository.getUserinfo(userId);
  }

  void setUserInfo() async {
    if (user != null) {
      //端末にデータを保存
      await shareData.setInstance();
      shareData.setStringShareData("id", user!.id);
      shareData.setStringShareData("email", user!.email);
      shareData.setStringShareData("userName", user!.userName);
    }
  }
}
