import 'package:cooking_record/page/record/base_record_view_model.dart';
import 'package:flutter/foundation.dart';

class EditRecordViewModel extends BaseRecordViewModel {
  Future updateRecord() async {
    try {
      await addNewTags();
      await recordRepository.updateRecord(record, imgFilePath);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteRecord() async {
    try {
      await recordRepository.deleteRecord(record);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
