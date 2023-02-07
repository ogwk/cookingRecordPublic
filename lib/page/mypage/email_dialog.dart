// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'package:cooking_record/page/mypage/mypage_view_model.dart';
import 'package:cooking_record/unit/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

StatefulBuilder changeEmailDialog(
    context, MyPageViewModel viewModel, String oldEmail) {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String changeEmail = "";
  String password = "";

  return StatefulBuilder(builder: (context, setState) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: const Text("メールアドレス変更"),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: '新しいメールアドレス',
                  ),
                  initialValue: changeEmail,
                  onChanged: (value) {
                    changeEmail = value.trim();
                  },
                  validator: (String? value) {
                    return checkEmail(value);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(viewModel.isHideDisplayPassword != true
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            viewModel.isHideDisplayPassword =
                                !viewModel.isHideDisplayPassword;
                          });
                        },
                      ),
                      hintText: "パスワード"),
                  obscureText: viewModel.isHideDisplayPassword,
                  validator: (value) {
                    return checkNull(value);
                  },
                  onChanged: (value) => password = value.trim(),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text("キャンセル")),
        TextButton(
          child: const Text("変更する"),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await changeToNewEmail(
                  viewModel, oldEmail, password, context, changeEmail);
            }
          },
        )
      ],
    );
  });
}

Future<void> changeToNewEmail(MyPageViewModel viewModel, String oldEmail,
    String password, BuildContext context, String changeEmail) async {
  EasyLoading.show();
  //一旦ログイン
  await viewModel.login(oldEmail, password);

  if (viewModel.isLoginError) {
    EasyLoading.dismiss();
    showConfirmDialog(context, viewModel.errorMessage);
  } else {
    await viewModel.changeEmail(oldEmail, changeEmail, password);
    EasyLoading.dismiss();
    Navigator.pop(context);
  }
  EasyLoading.dismiss();
}

String? checkEmail(String? value) {
  if (value == null || value.trim() == "") {
    return '必須入力です。';
  } else if (!value.contains("@")) {
    return 'メールアドレスの形式が間違っています。';
  } else {
    return null;
  }
}

String? checkNull(String? value) {
  return (value == null || value.trim() == "") ? '必須入力です。' : null;
}
