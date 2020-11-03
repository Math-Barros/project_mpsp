import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_mpsp/models/post_model.dart';

class FirebaseUtils {
  static final StorageReference notificationsStorageReference =
      FirebaseStorage.instance.ref().child(Constants.statues);

  static CollectionReference statuesCollectionsReference =
      FirebaseFirestore.instance.collection(Constants.statues);

  static Future<String> uploadImageToStorage(File file) async {
    print("uploadImageToStorage");
    final StorageUploadTask storageUploadTask = notificationsStorageReference
        .child(Utilities.getFileName(file))
        .putFile(file);
    final StorageTaskSnapshot storageTaskSnapshot =
        (await storageUploadTask.onComplete);
    final url = (await storageTaskSnapshot.ref.getDownloadURL());
    print("url : $url");
    return url;
  }

  static Future postNotification(PostModel model, String filePath) async {
    if (filePath != null) {
      // here deleteing old image from storage
      if (model.imageURL != null && model.imageURL.contains("https://")) {
        await FirebaseStorage.instance
            .getReferenceFromUrl(model.imageURL)
            .then((onValue) {
          onValue.delete();
        });
      }

      model.imageURL = await uploadImageToStorage(File(filePath));
      print("addProdcut url ${model.imageURL}");
    }

    DocumentReference ref = statuesCollectionsReference.doc();

    if (model.docid != null) {
      ref = statuesCollectionsReference.doc(model.docid);
    }
    model.docid = ref.id;
    model.imageURL = model.imageURL;
    print(model.toMap().toString());
    return await ref.set(model.toMap());
  }

  static updateFirebaseToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    String token = await firebaseMessaging.getToken();
    print("updateFirebaseToken $token");
    User user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .update({'firebaseToken': token});
  }

  static removeFirebaseToken() async {
    User user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .update({'firebaseToken': ''});
  }
}

class Constants {
  static String statues = "statuses";
  static String count = "count";
}

class Utilities {
  static getFileName(File file) {
    String name = path.basename(file.path);
    return name;
  }
}

class MyCircleLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
