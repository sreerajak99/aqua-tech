import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class WaterUsageGraph extends StatelessWidget {
  final List<double> monthlyUsage;

  const WaterUsageGraph({Key? key, required this.monthlyUsage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      height: 260,
      width: MediaQuery.of(context).size.width *0.95,
      padding: const EdgeInsets.only(left: 20, top: 18, right: 15),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const months = [
                    'Jan',
                    'feb',
                    'Mar',
                    'Apr',
                    'Ma',
                    'Jun',
                    'Jul',
                    'Aug',
                    'Sep',
                    'Oct',
                    'Nov',
                    'Dec'
                  ];
                  if (value.toInt() < 0 || value.toInt() >= months.length) {
                    return const Text('');
                  }
                  return Text(months[value.toInt()]);
                },
                reservedSize: 25,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                reservedSize: 16,
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}');
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: monthlyUsage.reduce((curr, next) => curr > next ? curr : next),
          lineBarsData: [
            LineChartBarData(
              spots: monthlyUsage.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value);
              }).toList(),
              isCurved: true,
              color: Colors.white,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData:
                  BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
            ),
          ],
        ),
      ),
    );
  }
}
