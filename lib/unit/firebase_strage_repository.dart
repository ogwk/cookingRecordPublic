import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageRepository {
  static final FirebaseStorageRepository singleton =
      FirebaseStorageRepository._internal();
  FirebaseStorageRepository._internal();

  factory FirebaseStorageRepository() {
    return singleton;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<String> uploadFileFromFile(
      String filepath, String folderName, String uploadFileName) async {
    if (filepath == "") return "";
    File file = File(filepath);
    try {
      var snapshot =
          await storage.ref("$folderName/$uploadFileName.png").putFile(file);
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException {
      return "";
      //エラー処理
    }
  }

  Future<void> deleteFileFromFile(String imageUrl) async {
    if (imageUrl == "") return;
    final storageReference = FirebaseStorage.instance.refFromURL(imageUrl);

    try {
      await storageReference.delete();
    } on FirebaseException {
      //エラー処理
      if (kDebugMode) {
        print("Error deleteStrage");
      }
      return;
    }
  }
}
