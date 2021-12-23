import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MonthlySummary {
  int year = 2021;
  int month = 1;
  Map<int, int> dayIncomeMap;

  MonthlySummary({this.year, this.month, this.dayIncomeMap});

  factory MonthlySummary.fromFirestore(
      DocumentSnapshot doc, int year, int month) {
    if (doc == null)
      debugPrint("CIAPP ERROR: finance transaction docsnap null");

    Map data = doc.data();
    var max = DateUtils.getDaysInMonth(year, month);

    Map<int, int> newMap = new Map<int, int>();
    int runningAmount = 0;

    // debugPrint(data.toString());

    for (int i = 0; i < max; i++) {
      if (data == null) {
        newMap[i] = runningAmount;
        continue;
      }
      if (data.containsKey("${i + 1}")) {
        newMap[i] = data["${i + 1}"];
        runningAmount = newMap[i];
      } else {
        newMap[i] = runningAmount;
      }
    }

    return MonthlySummary(year: year, month: month, dayIncomeMap: newMap);
  }
}
