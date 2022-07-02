
// class FinanceMonth {
//   // static final month_names List<String> = ["jan", "feb", "mar", "april", "may", "june", "july", "agust", "september", "oct", "nov", "dec"];

//   int month;
//   Stream<List<FinanceTransaction>> finance_transactions;
//   int opening_balance = 10000;

//   FinanceMonth({this.month, this.opening_balance, this.finance_transactions});
// }

// class FinanceTransaction {
//   String type;
//   int amount;

//   FinanceTransaction({this.type, this.amount});

//   factory FinanceTransaction.FromFirestore(DocumentSnapshot doc) {
//     if (doc == null)
//       debugPrint("CIAPP ERROR: finance transaction docsnap null");
//     Map data = doc.data();
//     return FinanceTransaction(type: data['type'], amount: data['amount']);
//   }
// }


