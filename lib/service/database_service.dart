import 'package:ciapp/constants.dart';
import 'package:ciapp/models/ci_user.dart';
import 'package:ciapp/models/feed_article.dart';
import 'package:ciapp/models/monthly_summary.dart';
import 'package:ciapp/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  static final DatabaseService _dbService = new DatabaseService._internal();

  factory DatabaseService() {
    return _dbService;
  }

  DatabaseService._internal() {}

  Stream<CIUser> streamCIUser(String uid) {
    return _db
        .collection('ci_users')
        .doc(uid)
        .snapshots()
        .map((snap) => CIUser.fromFirestore(snap));
  }

  Future<CIUser> getCIUser(String uid) async {
    try {
      return await _db
          .collection('ci_users')
          .doc(uid)
          .get()
          .then((docSnap) => CIUser.fromFirestore(docSnap));
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR: " + e.toString());
    }
  }

  Future<void> createCIUser(
    String uid,
    String firstName,
    String lastName,
    String address,
    String phoneNumber,
  ) async {
    try {
      await _db.collection('ci_users').doc(uid).set({
        "first_name": firstName,
        "last_name": lastName,
        "rank": "Guest",
        "address": address,
        "profile_URL":
            "https://scontent.fbir2-1.fna.fbcdn.net/v/t1.6435-9/186245676_328614285276080_2606505843490955899_n.png?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=3YWbXntm4qUAX-5TyqS&_nc_ht=scontent.fbir2-1.fna&oh=6c79d7d4a94d5ec515646aa8b23021eb&oe=60D4B9CA",
            "phone_number": int.parse(phoneNumber),
        "exp_points": 0,
        "level": 1,
        "hearts": 0,
        "profileVisits": 0,
        "joinedAt": Timestamp.fromDate(DateTime.now()),
        "roles": {
          "guest": true,
        },
      });
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR: " + e.toString());
      return "Error";
    }
  }

  Future<void> updateCIUser(CIUser ci_user) {
    try {
      var ref = _db.collection('ci_users').doc(ci_user.doc_id);
      ref.update(ci_user.toUpdatableFieldOnlyMap());
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR: " + e.toString());
    }
  }

  Stream<List<Task>> streamTask(String uid) {
    try {
      var ref = _db
          .collection("ci_users")
          .doc(uid)
          .collection("tasks")
          .orderBy("isDone");
      Stream<List<Task>> tasks = ref.snapshots().map(
          (list) => list.docs.map((doc) => Task.fromFirestore(doc)).toList());
      return tasks;
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR: " + e.toString());
    }
    return null;
  }

  Future<DocumentReference> addTask(String uid, Task task) {
    try {
      var ref = _db.collection("ci_users").doc(uid).collection("tasks");
      return ref.add(task.toMap());
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR: " + e.toString());
    }
  }

  Future<void> updateTask(String uid, Task task) {
    try {
      var ref = _db
          .collection("ci_users")
          .doc(uid)
          .collection("tasks")
          .doc(task.doc_id);
      return ref.update(task.toMap());
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR: " + e.toString());
    }
  }

  Future<void> deleteTask(String uid, Task task) {
    try {
      _db
          .collection("ci_users")
          .doc(uid)
          .collection("tasks")
          .doc(task.doc_id)
          .delete();
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR(DATABASE): " + e.toString());
    }
  }

  Stream<MonthlySummary> streamMonthlySummary(String uid, int year, int month) {
    try {
      return _db
          .collection("finance")
          .doc(year.toString())
          .collection(kMonthNames[month-1].toLowerCase())
          .doc("daily_summary")
          .snapshots()
          .map((doc) => MonthlySummary.fromFirestore(doc, year, month));
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR(DATABASE): " + e.toString());
    }
  }

  Stream<List<FeedArticle>> streamAllFeedArticles() {
    try {
      return _db.collection("articles").snapshots().map((list) =>
          list.docs.map((doc) => FeedArticle.fromFirestore(doc)).toList());
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR(DATABASE): " + e.toString());
    }
  }

  Future<List<FeedArticle>> getAllFeedArticles() async {
    try {
      return await _db
          .collection("articles")
          .orderBy("createdAt", descending: false)
          .get()
          .then((onValue) {
        return onValue.docs.map((docSnap) {
          return FeedArticle.fromFirestore(docSnap);
        }).toList();
      });
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR(DATABASE): " + e.toString());
      return null;
    }
  }

  Stream<FeedArticle> streamArticles() async* {
    try {
      debugPrint("awaiting!");
      var querySnapshots = await _db
          .collection("articles")
          .orderBy("createdAt", descending: true)
          .get();

      debugPrint("querySnapshots!");

      for (var docSnap in querySnapshots.docs) {
        debugPrint("article");
        yield FeedArticle.fromFirestore(docSnap);
      }
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR(DATABASE): " + e.toString());
    }
  }

  Future<List<FeedArticle>> getAllUserFeedArticles(String uid) async {
    try {
      return await _db
          .collection("articles")
          .where("writtenBy", isEqualTo: uid)
          .get()
          .then((onValue) {
        return onValue.docs.map((docSnap) {
          return FeedArticle.fromFirestore(docSnap);
        }).toList();
      });
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR(DATABASE): " + e.toString());
      return null;
    }
  }

  Stream<FeedArticle> streamArticle(String doc_id) {
    try {
      return _db
          .collection("articles")
          .doc(doc_id)
          .snapshots()
          .map((snap) => FeedArticle.fromFirestore(snap));
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR(DATABASE): " + e.toString());
    }
  }

  Future<void> updateArticle(FeedArticle article) {
    try {
      var ref = _db.collection("articles").doc(article.doc_id);
      return ref.update(article.toUpdatableFieldOnlyMap());
    } on Exception catch (e) {
      debugPrint("CIAPP ERROR: " + e.toString());
    }
  }
}
