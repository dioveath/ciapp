import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  String? doc_id;
  String? title;
  String? desc;
  bool isDone;
  Map<dynamic, dynamic>? todos;
  DateTime? createdAt;
  DateTime? doneAt;

  Task(
      {this.doc_id,
      this.title,
      this.desc,
      this.isDone = false,
      this.todos,
      this.createdAt,
      this.doneAt});

  factory Task.fromFirestore(DocumentSnapshot doc) {
    if (doc == null) debugPrint("task docsnap is null");
    Map data = doc.data() as Map<dynamic, dynamic>;

    DateTime _createdAt = DateTime(2000, 1, 1, 1, 1);
    if (data['createdAt'] != null)
      _createdAt = DateTime.fromMicrosecondsSinceEpoch(
          data['createdAt'].microsecondsSinceEpoch);

    DateTime _doneAt = DateTime(2000, 1, 1, 1, 1);
    if (data['doneAt'] != null)
      _doneAt = DateTime.fromMicrosecondsSinceEpoch(
          data['doneAt'].microsecondsSinceEpoch);

        

    return Task(
      doc_id: doc.id,
      title: data['title'],
      desc: data['desc'],
      isDone: data['isDone'] ?? false,
      todos: data['todos'] ?? {},
      createdAt: _createdAt,
      doneAt: _doneAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "desc": desc,
      "isDone": isDone,
      "todos": todos,
      "createdAt": createdAt,
      "doneAt": doneAt,
    };
  }
}
