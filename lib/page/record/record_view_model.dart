import 'package:cooking_record/page/record/base_record_view_model.dart';
import 'package:flutter/foundation.dart';

class RecordViewModel extends BaseRecordViewModel {
  Future addRecord() async {
    try {
      await addNewTags();
      await recordRepository.addNewRecord(user!, record, imgFilePath);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
