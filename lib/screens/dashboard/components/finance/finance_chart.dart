import 'package:ciapp/constants.dart';
import 'package:ciapp/models/monthly_summary.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class FinanceChart extends StatelessWidget {
  Widget build(BuildContext context) {
    var mon_sum = context.watch<MonthlySummary>();
    int today = DateTime.now().day;

    if (mon_sum == null)
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );

    return LineChart(buildLineChartData(mon_sum, today),
        swapAnimationDuration: Duration(milliseconds: 1000),
        swapAnimationCurve: Curves.ease);
  }

  LineChartData buildLineChartData(MonthlySummary mon_sum, today) {
    Map<int, int> incomeMap = mon_sum.dayIncomeMap;
    var hAmount = 0;

    for (int i = 0; i < incomeMap.length; i++) {
      if (incomeMap[i] > hAmount) hAmount = incomeMap[i];
    }

    var interval = hAmount / 8;
    if (interval == 0) interval = 100;
    var c = '';
    List<String> ltList = [];



    for (int i = 0; i < 5; i++) {
      double val = interval * (i + 1) * 2;
      if (val < 1000) {
        c = "Rs";
      } else if (val < 100000) {
        val = (val / 1000);
        c = "K";
      } else {
        c = "L";
        val = val / 100000;
      }
      ltList.add("${val.toStringAsFixed(1)}" + c);
    }

    double maxX = incomeMap.length.toDouble();

    return LineChartData(
      lineBarsData: getLineChartBarDataUpToDay(incomeMap, hAmount, today),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTextStyles: (value) => const TextStyle(
            color: kBackgroundColor,
            fontSize: 8.0,
            fontFamily: "GlacialIndifference",
          ),
          getTitles: (value) {
            return value <= 1
                ? ''
                : value.toInt() % 2 == 1
                    ? ''
                    : ltList[(value ~/ 2) - 1];
          },
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTextStyles: (value) => const TextStyle(
            color: kBackgroundColor,
            fontSize: 6.0,
            fontFamily: "GlacialIndifference",
          ),
          getTitles: (value) {
            return '${value.toInt() + 1}';
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) =>
            FlLine(color: kBackgroundColor.withOpacity(0.3), strokeWidth: 0.5),
        drawVerticalLine: true,
        getDrawingVerticalLine: (value) =>
            FlLine(color: kBackgroundColor.withOpacity(0.3), strokeWidth: 0.5),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: kBackgroundColor.withOpacity(0.5), width: 1),
      ),
      minX: 0,
      maxX: maxX,
      minY: 0,
      maxY: 10,
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            List<LineTooltipItem> lineTooltipList = [];
            touchedSpots.forEach((val) => {
                  lineTooltipList.add(LineTooltipItem(
                      "${incomeMap[val.spotIndex]}",
                      TextStyle(
                          color: kBackgroundColor,
                          backgroundColor: kPrimaryColor,
                          fontFamily: "GlacialIndifference",
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)))
                });
            return lineTooltipList;
          },
          tooltipBgColor: kPrimaryColor,
        ),
      ),
    );
  }

  List<LineChartBarData> getLineChartBarDataUpToDay(
      Map<int, int> incomeMap, int max, int day) {
    List<FlSpot> spotList = [];

    incomeMap.forEach((key, val) {
      if (key > (day - 1)) return;
      spotList.add(FlSpot(key.toDouble(), max != 0 ? val / max * 8 : 0));
    });

    return [
      LineChartBarData(
        show: true,
        spots: spotList,
        colors: [
          kBackgroundColor,
        ],
        barWidth: 1,
        isCurved: true,
        belowBarData: BarAreaData(
          show: true,
          colors: [
            kPrimaryColor.withOpacity(0.7),
          ],
        ),
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, dblValue, data, intValue) {
            return FlDotCirclePainter(
                color: kBackgroundColor,
                strokeColor: kBackgroundColor,
                radius: 2);
          },
        ),
      ),
    ];
  }
}
