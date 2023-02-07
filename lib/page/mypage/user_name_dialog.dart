// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:cooking_record/page/mypage/mypage_view_model.dart';
import 'package:cooking_record/unit/err_check_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

StatefulBuilder registerUserNameDialog(
    context, MyPageViewModel viewModel, String userName) {
  String changeUserName = userName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return StatefulBuilder(builder: (context, setState) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: const Text("ユーザー名変更"),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            initialValue: userName,
            onChanged: (value) {
              changeUserName = value.trim();
            },
            validator: (value) {
              return ErrCheckFunction.singleton.checkNull(value);
            },
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("キャンセル")),
        TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                EasyLoading.show();
                await viewModel.changeUserName(changeUserName);
                EasyLoading.dismiss();
                Navigator.pop(context);
              }
            },
            child: const Text("変更する"))
      ],
    );
  });
}
