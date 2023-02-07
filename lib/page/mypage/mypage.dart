import 'package:cooking_record/page/mypage/email_dialog.dart';
import 'package:cooking_record/page/mypage/mypage_view_model.dart';
import 'package:cooking_record/page/mypage/password_dialog.dart';
import 'package:cooking_record/page/mypage/user_name_dialog.dart';
import 'package:cooking_record/page/top/top_page.dart';
import 'package:cooking_record/unit/dialog/dialog.dart';
import 'package:cooking_record/unit/firebase_auth_repository.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final viewModel = MyPageViewModel();

  Future<void> _getUser() async {
    await viewModel.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("マイページ"),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: _getUser(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: SizedBox(
                      width: double.infinity,
                      child: rowWidget("ユーザーID",
                          viewModel.user != null ? viewModel.user!.id : ""),
                    ),
                  ),
                  InkWell(
                    child: rowWidget("ユーザー名",
                        viewModel.user != null ? viewModel.user!.userName : ""),
                    onTap: () async {
                      final userName = viewModel.user != null
                          ? viewModel.user!.userName
                          : "";
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return registerUserNameDialog(
                                context, viewModel, userName);
                          });
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: rowWidget("メールアドレス",
                        viewModel.user != null ? viewModel.user!.email : ""),
                    onTap: () async {
                      final userEmail =
                          viewModel.user != null ? viewModel.user!.email : "";
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return changeEmailDialog(
                                context, viewModel, userEmail);
                          });
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: changePasswordWidget("パスワードを変更する"),
                    onTap: () async {
                      final userEmail =
                          viewModel.user != null ? viewModel.user!.email : "";
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return changePasswordDialog(
                                context, viewModel, userEmail);
                          });
                      setState(() {});
                    },
                  ),
                  InkWell(
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text(
                            "ログアウト",
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        )),
                    onTap: () async {
                      showDialogYesNo(
                          context, "ログアウトする", "ログアウトします。\n よろしいですか？", _logout);
                    },
                  ),
                ],
              ),
            );
          }
        },
      )),
    );
  }

  void _logout() {
    FirebaseAuthRepository.singleton.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const TopPage('');
      }));
    });
  }

  Container rowWidget(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Container changePasswordWidget(String title) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
