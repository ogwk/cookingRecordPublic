import 'package:cooking_record/extension/date_time_ex.dart';
import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/page/myrecords/myrecords_view_model.dart';
import 'package:cooking_record/page/myrecords/search/search.dart';
import 'package:cooking_record/page/record/edit_record.dart';
import 'package:cooking_record/page/record/record.dart';
import 'package:cooking_record/unit/image/image.dart';
import 'package:flutter/material.dart';

class MyRecordsPage extends StatefulWidget {
  const MyRecordsPage({Key? key}) : super(key: key);

  @override
  State<MyRecordsPage> createState() => _MyRecordsPageState();
}

class _MyRecordsPageState extends State<MyRecordsPage> {
  final MyRecordsViewModel viewModel = MyRecordsViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<List<Record>> _getRecords() async {
    await viewModel.getMyRecords();
    return viewModel.myRecords;
  }

  void fncTapCard(Record record) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditRecordPage(record)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    isReload() {
      setState(() {});
    }

    return Scaffold(
        appBar: AppBar(
          title: appBarDate(isReload),
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Search()));
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Record record = const Record(id: "", title: "");
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => RecordPage(record)));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder(
          future: _getRecords(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              if (viewModel.myRecords.isEmpty) {
                return const Center(
                    child: Text(
                        'データが登録されていません。\nデータがある年月を選択するか、\n右下の＋ボタンから記録を登録しましょう。'));
              } else {
                return ListView.builder(
                    itemCount: viewModel.myRecords.length,
                    itemBuilder: (context, index) {
                      return buildCard(viewModel.myRecords[index]);
                    });
              }
            } else {
              return const Center(
                  child: Text(
                      'データが登録されていません。\nデータがある年月を選択するか、\n右下の＋ボタンから記録を登録しましょう。'));
            }
          },
        ));
  }

  StatefulBuilder appBarDate(Function reload) {
    return StatefulBuilder(builder: (context, setState) {
      return Row(
        children: [
          DropdownButton(
            items: viewModel
                .getYears()
                .map((year) =>
                    DropdownMenuItem(value: year, child: Text(year.toString())))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                viewModel.setYear = value!;
              });
              reload();
            },
            value: viewModel.selectedYear,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const Text("年"),
          const SizedBox(
            width: 10,
          ),
          DropdownButton(
            items: viewModel
                .getMonths()
                .map((month) => DropdownMenuItem(
                    value: month, child: Text(month.toString())))
                .toList(),
            onChanged: (String? value) {
              setState(() {
                viewModel.setMonth = value!;
              });
              reload();
            },
            value: viewModel.selectedMonth,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text("月"),
        ],
      );
    });
  }

  Widget buildCard(Record record) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditRecordPage(record)));
        setState(() {});
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(children: <Widget>[
            Container(
                padding: const EdgeInsets.all(10),
                child: netImageBox(100.0, 128.0, record.imageUrl)),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        record.title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Text(
                            record.date != null
                                ? record.date!.getJapaneseDateE().toString()
                                : "-年-月-日",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          (record.isDone)
                              ? const Icon(Icons.done, color: Colors.red)
                              : Container(),
                        ],
                      ),
                    ],
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}

List<int> getYears() {
  List<int> years = [];
  int startYear = 2021;
  int nowYear = DateTime.now().year.toInt();
  int endYear = DateTime(nowYear + 5, 1, 1).year.toInt();
  for (int year = startYear; year <= endYear; year++) {
    years.add(year);
  }
  return years;
}

List<int> getMonths() {
  List<int> months = [];
  for (int month = 1; month <= 12; month++) {
    months.add(month);
  }
  return months;
}
