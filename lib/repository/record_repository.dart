import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/model/user.dart';
import 'package:cooking_record/unit/firebase_strage_repository.dart';
import 'package:cooking_record/unit/shared_preference.dart';
import 'package:flutter/foundation.dart';

class RecordRepository {
  final db = FirebaseFirestore.instance;
  final ShareData shareData = ShareData();

  Future<void> addNewRecord(
      User user, Record record, String imgFilePath) async {
    final colRef =
        db.collection("user").doc(user.id).collection("cookingRecord");
    final recordId = colRef.doc().id;
    final imageUrl = (imgFilePath == "")
        ? ""
        : await FirebaseStorageRepository.singleton.uploadFileFromFile(
            imgFilePath, "${user.id}/cookingRecord", recordId);
    final tags = [];
    for (var tag in record.tags) {
      tags.add(tag.toJson());
    }

    try {
      await colRef.doc(recordId).set({
        'id': recordId,
        'title': record.title,
        'recipeUrl': record.recipeUrl,
        'memo': record.memo,
        'isOpen': record.isOpen,
        'date': record.date != null ? Timestamp.fromDate(record.date!) : null,
        'imageUrl': imageUrl,
        'tags': tags,
        'likeUserIds': [],
        'userId': user.id,
        'userName': user.userName,
        'userImgUrl': user.imageUrl,
        'registerDate': Timestamp.fromDate(DateTime.now()),
        'updateDate': Timestamp.fromDate(DateTime.now()),
        'isDone': record.isDone,
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error ${e.toString()}");
      }
    }
  }

  Future<void> updateRecord(Record record, String imgFilePath) async {
    final colRef =
        db.collection("user").doc(record.userId).collection("cookingRecord");
    final userId = shareData.getStringShareData('id');

    if (imgFilePath != "") {
      //画像パスが変更された時に更新
      final imageUrl = await FirebaseStorageRepository.singleton
          .uploadFileFromFile(imgFilePath, "$userId/cookingRecord", record.id);
      record = record.copyWith(imageUrl: imageUrl);
    }
    final tags = [];
    for (var tag in record.tags) {
      tags.add(tag.toJson());
    }

    try {
      await colRef.doc(record.id).update({
        'title': record.title,
        'recipeUrl': record.recipeUrl,
        'memo': record.memo,
        'isOpen': record.isOpen,
        'date': record.date != null ? Timestamp.fromDate(record.date!) : null,
        'imageUrl': record.imageUrl,
        'tags': tags,
        'updateDate': Timestamp.fromDate(DateTime.now()),
        'isDone': record.isDone,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> deleteRecord(Record record) async {
    try {
      final docRef = db
          .collection("user")
          .doc(record.userId)
          .collection("cookingRecord")
          .doc(record.id);
      await docRef.delete();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    //storageファイルの削除
    await FirebaseStorageRepository.singleton
        .deleteFileFromFile(record.imageUrl);
  }
}
