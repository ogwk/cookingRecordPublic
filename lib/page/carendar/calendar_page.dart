import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/page/carendar/calendar_view_model.dart';
import 'package:cooking_record/page/carendar/calendar_column.dart';
import 'package:cooking_record/page/record/record.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarViewModel viewModel = CalendarViewModel();

  Future<Map<DateTime, dynamic>> getRecordList() async {
    await viewModel.getMyRecords();
    await viewModel.addRecords();
    return viewModel.recordList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("カレンダー"),
        actions: [
          IconButton(
              onPressed: () async {
                Record record =
                    Record(id: "", title: "", date: viewModel.selectedDay);
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecordPage(record)));
                setState(() {});
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getRecordList(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return CalendarColumn(viewModel);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
