import 'package:cooking_record/const/custom_type.dart';
import 'package:cooking_record/page/top/top_page.dart';
import 'package:cooking_record/repository/login_repository.dart';
import 'package:cooking_record/unit/authentication_error.dart';
import 'package:cooking_record/unit/dialog/dialog.dart';
import 'package:cooking_record/unit/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [Tab(child: Text("ログイン")), Tab(child: Text("新規登録"))],
            ),
          ),
          body: const TabBarView(children: [_Login(), _Register()]),
        ));
  }
}

class _Login extends StatefulWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<_Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  bool _isDisplay = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(hintText: "メールアドレス"),
                  validator: (String? value) {
                    return checkEmail(value);
                  },
                  onChanged: (value) => _email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: _isDisplay,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_isDisplay != true
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isDisplay = !_isDisplay;
                          });
                        },
                      ),
                      hintText: "パスワード"),
                  validator: (String? value) {
                    return checkPassword(value);
                  },
                  onChanged: (value) => _password = value,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final FirebaseAuthResultStatus signInResult =
                        await FirebaseAuthRepository.singleton
                            .login(_email, _password);
                    if (signInResult != FirebaseAuthResultStatus.successful) {
                      final errorMessage =
                          FirebaseAuthExceptionHandler.exceptionMessage(
                              signInResult);

                      if (!mounted) return;
                      showConfirmDialog(context, errorMessage);
                    } else {
                      if (!mounted) return;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const TopPage('');
                      }));
                    }
                  }
                },
                child: const Text('ログイン'),
              ),
            ],
          ),
        ));
  }
}

class _Register extends StatefulWidget {
  const _Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<_Register> {
  final _formKey = GlobalKey<FormState>();
  String _userName = "";
  String _email = "";
  String _password = "";
  bool _isDisplay = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "ユーザー名"),
                    validator: (String? value) {
                      return (value == null || value == "") ? '必須入力です。' : null;
                    },
                    onChanged: (value) => _userName = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "メールアドレス"),
                    validator: (String? value) {
                      return checkEmail(value);
                    },
                    onChanged: (value) => _email = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: _isDisplay,
                    decoration: InputDecoration(
                      hintText: "パスワード(6文字以上）",
                      suffixIcon: IconButton(
                        icon: Icon(_isDisplay != true
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isDisplay = !_isDisplay;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      return checkPassword(value);
                    },
                    onChanged: (value) => _password = value,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final loginRepository = LoginRepository();
                      //ユーザー登録
                      EasyLoading.show();
                      final FirebaseAuthResultStatus registerResult =
                          await loginRepository.registerUser(
                              _userName, _email, _password);
                      EasyLoading.dismiss();
                      if (registerResult !=
                          FirebaseAuthResultStatus.successful) {
                        final errorMessage =
                            FirebaseAuthExceptionHandler.exceptionMessage(
                                registerResult);
                        if (!mounted) return;
                        showConfirmDialog(context, errorMessage);
                      } else {
                        if (!mounted) return;
                        showConfirmDialog(context, "登録が完了しました");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          const shareUrl = '';
                          return const TopPage(shareUrl);
                        }));
                      }
                    }
                  },
                  child: const Text('新規登録'),
                ),
              ],
            ),
          ),
        ));
  }
}

String? checkPassword(String? value) {
  return (value != null && value.length < 6) ? 'パスワードは6文字以上で入力してください。' : null;
}

String? checkEmail(String? value) {
  return (value != null && !value.contains('@')) ? 'メールアドレスの形式が間違っています。' : null;
}
