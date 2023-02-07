import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/repository/myrecords_repository.dart';

class MyRecordsViewModel {
  List<Record> myRecords = [];
  MyRecordsRepository myRecordsRepository = MyRecordsRepository();

  String selectedYear = DateTime.now().year.toString();
  String selectedMonth = DateTime.now().month.toString();

  MyRecordsViewModel() {
    getMyRecords();
  }

  Future<List<Record>> getMyRecords() async {
    myRecords =
        await myRecordsRepository.getRecords(selectedYear, selectedMonth);
    return myRecords;
  }

  set setYear(String year) {
    selectedYear = year;
  }

  set setMonth(String month) {
    selectedMonth = month;
  }

  List<String> getYears() {
    List<String> years = [];
    int startYear = 2021;
    int nowYear = DateTime.now().year.toInt();
    int endYear = DateTime(nowYear + 5, 1, 1).year.toInt();
    for (int year = startYear; year <= endYear; year++) {
      years.add(year.toString());
    }
    return years;
  }

  List<String> getMonths() {
    List<String> months = [];
    for (int month = 1; month <= 12; month++) {
      months.add(month.toString());
    }
    return months;
  }
}
