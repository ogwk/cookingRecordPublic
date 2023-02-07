import 'dart:collection';
import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/repository/myrecords_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarViewModel {
  MyRecordsRepository myRecordsRepository = MyRecordsRepository();

  int? intHashcode;
  DateTime focusedDay = DateTime.now();
  late DateTime? selectedDay = focusedDay;
  List<Record> myRecords = [];
  Map<DateTime, List> recordList = {};
  late LinkedHashMap records;

  List getRecord(DateTime day) {
    return records[day] ?? [];
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  set setFocusedDay(DateTime date) {
    focusedDay = date;
  }

  set setSelectedDay(DateTime date) {
    selectedDay = date;
  }

  Future<void> getMyRecords() async {
    myRecords = await myRecordsRepository.getAllRecords();

    //初期化
    recordList = {};
    for (var record in myRecords) {
      //日付がnullの場合は次の処理へ
      if (record.date == null) continue;
      final date = record.date!;
      if (recordList.containsKey(date)) {
        //  日付が既に存在している場合
        recordList[date]!.add(record);
      } else {
        //  存在していない場合
        recordList.addAll({
          date: [record]
        });
      }
    }
  }

  Future addRecords() async {
    records = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(recordList);
  }
}
