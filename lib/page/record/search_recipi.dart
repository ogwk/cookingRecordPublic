// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:io';
import 'package:cooking_record/unit/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchRecipe extends StatefulWidget {
  const SearchRecipe(this.siteUrl, {Key? key}) : super(key: key);
  final String siteUrl;

  @override
  State<SearchRecipe> createState() => _SearchRecipeState();
}

class _SearchRecipeState extends State<SearchRecipe> {
  @override
  void initState() {
    super.initState();
    // Androidに対応させる
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> controller =
        Completer<WebViewController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('レシピを探す'),
      ),
      body: WebView(
        initialUrl: widget.siteUrl, //表示したいWebページを指定する
        // jsを有効化
        javascriptMode: JavascriptMode.unrestricted,
        // controllerを登録
        onWebViewCreated: (WebViewController webController) {
          controller.complete(webController);
        },
      ),
      floatingActionButton: ElevatedButton(
        child: const Text("つくる"),
        onPressed: () async {
          try {
            //todo URL取得方法検討
            final futureController = await controller.future;
            final currentUrl = await futureController.currentUrl();

            if (!mounted) return;
            Navigator.of(context).pop(currentUrl);
            // ignore: void_checks
            return Future.value(false);
          } catch (e) {
            print(e);
            showConfirmDialog(context, e.toString());
          }
        },
      ),
    );
  }
}
