import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_record/model/tag.dart';
import 'package:flutter/foundation.dart';

class TagRepository {
  final db = FirebaseFirestore.instance;

  Future<List<Tag>> getTagList() async {
    List<Tag> tags = [];
    final colRef = db.collection("tag");

    await colRef.orderBy('tagName').get().then((res) {
      for (var item in res.docs) {
        final Map<String, dynamic> itemMap = item.data();
        itemMap["id"] = item.id;
        itemMap["addDate"] =
            (item["addDate"] as Timestamp?)?.toDate().toString();
        tags.add(
          Tag.fromJson(itemMap),
        );
      }
    });
    return tags;
  }

  Future<Tag?> addNewTag(String userId, Tag tag) async {
    final colRef = db.collection("tag");
    final tagId = colRef.doc().id;
    final Tag registerTag = Tag(
      id: tagId,
      tagName: tag.tagName,
      userId: userId,
      addDate: DateTime.now(),
    );

    try {
      await colRef.doc(tagId).set({
        'id': registerTag.id,
        'tagName': registerTag.tagName,
        'userId': registerTag.userId,
        'addDate': Timestamp.fromDate(registerTag.addDate!),
      });
      return registerTag;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
