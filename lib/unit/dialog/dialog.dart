import 'package:flutter/material.dart';

void showConfirmDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      );
    },
  );
}

void showDialogYesNo(
    BuildContext context, String title, String msg, Function fncAct) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          // ボタン領域
          TextButton(
              child: const Text("はい"),
              onPressed: () async {
                await fncAct();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }),
          TextButton(
            child: const Text("いいえ"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}
