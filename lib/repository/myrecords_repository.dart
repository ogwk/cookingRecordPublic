import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_record/model/record.dart';
import 'package:cooking_record/model/tag.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;

class MyRecordsRepository {
  final db = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<List<Record>> getRecords(String year, String month) async {
    final colRef =
        db.collection("user").doc(userId).collection("cookingRecord");
    List<Record> myRecords = [];
    await colRef.orderBy('date', descending: true).get().then((res) {
      for (var item in res.docs) {
        final Map<String, dynamic> itemMap = item.data();
        final date = (item["date"] as Timestamp?)?.toDate();

        if (date != null &&
            date.year.toString() == year &&
            date.month.toString() == month) {
          itemMap["id"] = item.id;
          itemMap["date"] = date.toString();
          itemMap["registerDate"] =
              ((item["registerDate"] as Timestamp).toDate().toString());
          myRecords.add(
            Record.fromJson(itemMap),
          );
        }
      }
    });
    return myRecords;
  }

  Future<List<Record>> getAllRecords() async {
    final colRef =
        db.collection("user").doc(userId).collection("cookingRecord");
    List<Record> myRecords = [];
    await colRef.orderBy('date', descending: true).get().then((res) {
      for (var item in res.docs) {
        final Map<String, dynamic> itemMap = item.data();
        itemMap["id"] = item.id;
        itemMap["date"] = (item["date"] as Timestamp?)?.toDate().toString();
        itemMap["registerDate"] =
            ((item["registerDate"] as Timestamp).toDate().toString());
        myRecords.add(
          Record.fromJson(itemMap),
        );
      }
    });
    return myRecords;
  }

  Future<List<Record>> getTagRecords(Tag tag) async {
    final colRef =
        db.collection("user").doc(userId).collection("cookingRecord");
    List<Record> myRecords = [];
    await colRef.orderBy('date', descending: true).get().then((res) {
      for (var item in res.docs) {
        final Map<String, dynamic> itemMap = item.data();
        dynamic searchTag = itemMap["tags"].firstWhere((dynamic t) {
          return t["id"] == tag.id;
        }, orElse: () => null);

        if (searchTag != null) {
          itemMap["date"] = (item["date"] as Timestamp?)?.toDate().toString();
          itemMap["registerDate"] =
              ((item["registerDate"] as Timestamp).toDate().toString());
          myRecords.add(
            Record.fromJson(itemMap),
          );
        }
      }
    });
    return myRecords;
  }
}
