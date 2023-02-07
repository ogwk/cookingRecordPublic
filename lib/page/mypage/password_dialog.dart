// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'package:cooking_record/page/mypage/mypage_view_model.dart';
import 'package:cooking_record/unit/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

StatefulBuilder changePasswordDialog(
    context, MyPageViewModel viewModel, String oldEmail) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String oldPassWord = "";
  String changePassWord = "";
  String changePassWordRe = "";

  return StatefulBuilder(builder: (context, setState) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: const Text("パスワード変更"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "古いパスワード",
                    suffixIcon: IconButton(
                      icon: obscureIcon(viewModel.isHideDisplayOldPassword),
                      onPressed: () {
                        setState(() {
                          viewModel.isHideDisplayOldPassword =
                              !viewModel.isHideDisplayOldPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: viewModel.isHideDisplayOldPassword,
                  initialValue: oldPassWord,
                  onChanged: (value) {
                    oldPassWord = value.trim();
                  },
                  validator: (String? value) {
                    return checkPassword(value);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "新しいパスワード",
                    suffixIcon: IconButton(
                      icon: obscureIcon(viewModel.isHideDisplayNewPassword),
                      onPressed: () {
                        setState(() {
                          viewModel.isHideDisplayNewPassword =
                              !viewModel.isHideDisplayNewPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: viewModel.isHideDisplayNewPassword,
                  validator: (value) {
                    return checkPassword(value);
                  },
                  onChanged: (value) => changePassWord = value.trim(),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "新しいパスワード（確認用）",
                    suffixIcon: IconButton(
                      icon: obscureIcon(viewModel.isHideDisplayNewPasswordRe),
                      onPressed: () {
                        setState(() {
                          viewModel.isHideDisplayNewPasswordRe =
                              !viewModel.isHideDisplayNewPasswordRe;
                        });
                      },
                    ),
                  ),
                  obscureText: viewModel.isHideDisplayNewPasswordRe,
                  validator: (value) {
                    return checkPasswordRe(value, changePassWord);
                  },
                  onChanged: (value) => changePassWordRe = value.trim(),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("キャンセル"),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("変更する"),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await changePassword(
                  viewModel, oldEmail, oldPassWord, context, changePassWord);
            }
          },
        )
      ],
    );
  });
}

Future<void> changePassword(MyPageViewModel viewModel, String oldEmail,
    String oldPassWord, BuildContext context, String changePassWord) async {
  EasyLoading.show();
  //一旦ログイン
  await viewModel.login(oldEmail, oldPassWord);

  if (viewModel.isLoginError) {
    EasyLoading.dismiss();
    showConfirmDialog(context, viewModel.errorMessage);
  } else {
    await viewModel.changePassword(oldEmail, oldPassWord, changePassWord);
    EasyLoading.dismiss();
    Navigator.pop(context);
  }
}

Icon obscureIcon(bool isHideDisplay) {
  return Icon(isHideDisplay != true ? Icons.visibility : Icons.visibility_off);
}

String? checkPasswordRe(String? value, String changePassWord) {
  if (value == null || value.trim() == "") {
    return '必須入力です。';
  } else if (!(value == changePassWord)) {
    return '上のパスワードと異なります。';
  } else {
    return null;
  }
}

String? checkPassword(String? value) {
  if (value == null || value.trim() == "") {
    return '必須入力です。';
  } else if (value.length < 6) {
    return 'パスワードは6文字以上で入力してください。';
  } else {
    return null;
  }
}
