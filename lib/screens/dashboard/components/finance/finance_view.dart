import 'package:ciapp/constants.dart';
import 'package:ciapp/models/monthly_summary.dart';
import 'package:ciapp/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'finance_chart.dart';

class FinanceView extends StatelessWidget {


  FinanceView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();

    var currentMonth = DateTime.now().month;
    var currentYear = DateTime.now().year;
    var today = DateTime.now().day;

    return Container(
      decoration: BoxDecoration(
        gradient: kDarkGradient, 
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: kSecondaryColor,
              alignment: Alignment.center,
              child: Text(
                  "Finance Summary of ${kMonthNames[currentMonth - 1]}",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: kBackgroundColor)),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(top: 14, right: 24),
              child: StreamProvider<MonthlySummary?>.value(
                initialData: null,
                value: DatabaseService().streamMonthlySummary(
                    user.uid, currentYear, currentMonth),
                child: FinanceChart(),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: StreamBuilder<MonthlySummary>(
                initialData: null,
                stream: DatabaseService().streamMonthlySummary(
                    user.uid, currentYear, currentMonth),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator());
                  var data = snapshot.data!;
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Opening Balance of ${kMonthNames[currentMonth - 1]} : Rs. ${data.dayIncomeMap![0]}",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal)),
                        // SizedBox(height: 4.0), 
                        Text(
                          "Todays Total Balance: Rs. ${data.dayIncomeMap![today - 1]} ",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal)),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
