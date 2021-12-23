import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedArticle {
  String doc_id = "NULL ID";
  String title = "Title";
  String body = "Description";
  String imageURL = "URL";

  // String summary = ""; // this is only for

  String writtenBy = "NULL WRITER";
  DateTime createdAt;
  int likes = 100;
  Map<dynamic, dynamic> heartsBy;

  FeedArticle({
    this.doc_id,
    this.title,
    this.body,
    this.imageURL,
    this.writtenBy,
    this.createdAt,
    this.likes,
    this.heartsBy,
  });

  String getReadTime() {
    double readTimeSec = body.length / 700 * 60;
    int readTimeMin = 0;
    String suffix = "Sec";
    if (readTimeSec >= 60) {
      suffix = "Min";
      readTimeMin = readTimeSec ~/ 60;
    }
    return "${readTimeMin == 0 ? readTimeSec.toInt() : readTimeMin} $suffix";
  }

  factory FeedArticle.fromFirestore(DocumentSnapshot doc) {
    if (doc == null) debugPrint("Task docsnap is null!");
    Map data = doc.data();

    // debugPrint(data.toString());

    return FeedArticle(
      doc_id: doc.id,
      title: data["title"],
      body: data["body"],
      imageURL: data["imageURL"],
      writtenBy: data["writtenBy"],
      createdAt: DateTime.fromMicrosecondsSinceEpoch(
          data["createdAt"].microsecondsSinceEpoch),
      likes: data["likes"],
      heartsBy: data["heartsBy"] ?? {},
    );
  }

  Map<String, dynamic> toUpdatableFieldOnlyMap() {
    return {
      "likes": likes,
      "heartsBy": heartsBy,
    };
  }
}
