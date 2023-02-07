import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/model/tag.dart';
import 'package:cooking_record/repository/myrecords_repository.dart';

class SearchResultFromTagViewModel {
  MyRecordsRepository myRecordsRepository = MyRecordsRepository();
  List<Record> getRecords = [];
  Future<List<Record>> getSearchRecord(Tag tag) async {
    List<Record> records = [];
    records = await myRecordsRepository.getTagRecords(tag);
    getRecords = records;
    return getRecords;
  }
}
