import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/page/carendar/calendar_page.dart';
import 'package:cooking_record/page/login_page.dart';
import 'package:cooking_record/page/mypage/mypage.dart';
import 'package:cooking_record/page/myrecords/myrecords.dart';
import 'package:cooking_record/page/record/record.dart';
import 'package:cooking_record/page/top/top_page_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage(this.sharedText, {Key? key}) : super(key: key);
  final String sharedText;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final viewModel = TopPageViewModel();
  List<Widget> displayPages = [
    const MyRecordsPage(),
    const CalendarPage(),
    const MyPage(),
  ];
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // スプラッシュ画面などに書き換えても良い
            return const SizedBox();
          }
          if (snapshot.hasData) {
            // User が null でない、つまりサインイン済みのホーム画面へ
            viewModel.getUserInfo().then((value) {
              viewModel.setUserInfo();
            });
            if (widget.sharedText != '') {
              Record record =
                  Record(id: '', title: '', recipeUrl: widget.sharedText);
              return RecordPage(record);
            }
            return top(context);
          }
          return const LoginPage();
        });
  }

  Widget top(BuildContext context) {
    return Scaffold(
      body: displayPages[indexPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexPage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: '私の記録',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'カレンダー',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'マイページ',
          ),
        ],
        selectedItemColor: Colors.blueAccent[200],
        onTap: (int index) => _tapAction(context, index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _tapAction(BuildContext context, int index) {
    indexPage = index;
    setState(() {});
  }
}
