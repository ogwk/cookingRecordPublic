// ignore_for_file: use_build_context_synchronously
import 'package:cooking_record/page/record/base_record_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void selectImage(
    BuildContext context, BaseRecordViewModel viewModel, Function reload) {
  bool isCamera = false;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return SimpleDialog(
        title: const Text('画像を追加'),
        children: [
          SimpleDialogOption(
            child: const Text('カメラで撮る',
                style: TextStyle(
                  color: Colors.blue,
                )),
            onPressed: () async {
              isCamera = true;
              EasyLoading.show();
              await viewModel.getImage(isCamera);
              reload();
              EasyLoading.dismiss();
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
            child: const Text('ライブラリから選択',
                style: TextStyle(
                  color: Colors.blue,
                )),
            onPressed: () async {
              isCamera = false;
              EasyLoading.show();
              await viewModel.getImage(isCamera);
              reload();
              EasyLoading.dismiss();
              Navigator.pop(context);
            },
          ),
          SimpleDialogOption(
              child: ElevatedButton(
                  child: const Text("キャンセル"),
                  onPressed: () {
                    Navigator.pop(context);
                  }))
        ],
      );
    },
  );
}

Future pickDate(BuildContext context, Function setDate) async {
  //DatePickerの初期値
  final initialDate = DateTime.now();
  //DatePickerを表示し、選択されたら変数に格納する
  final newDate = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      //初期値を設定
      initialDate: initialDate,
      //選択できる日付の上限　//todo 日付変更
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(DateTime.now().year + 2));

  //nullチェック
  if (newDate != null) {
    //選択された日付を変数に格納
    setDate(newDate);
  }
}
