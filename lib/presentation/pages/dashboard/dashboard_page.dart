import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../domain/finance/model/booking.dart';
import '../../../domain/finance/objects/booking_type.dart';
import '../../../domain/finance/mock/bookings_mock.dart'; // Pfad ggf. anpassen

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final recentBookings = mockBookings.take(10).toList();
    final chartData = _generateMonthlyChartData(mockBookings);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hey, Neil!'),
        actions: const [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lass uns den Nachmittag rocken!',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Einnahmen & Ausgaben',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  const Text('1000 CHF',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300)),
                  const SizedBox(height: 12),
                  AspectRatio(
                    aspectRatio: 1.6,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final month = DateFormat.MMM()
                                    .format(chartData[value.toInt()].month);
                                return Text(month,
                                    style: const TextStyle(fontSize: 10));
                              },
                              reservedSize: 28,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: chartData.asMap().entries.map((entry) {
                          final i = entry.key;
                          final e = entry.value;
                          return BarChartGroupData(x: i, barRods: [
                            BarChartRodData(
                              toY: e.amount.abs(),
                              width: 14,
                              color: e.amount >= 0 ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            )
                          ]);
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text('Letzte Buchungen',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Column(
              children: recentBookings.map((b) {
                final color =
                    b.type == BookingType.income ? Colors.green : Colors.red;
                final sign = b.type == BookingType.income ? '+' : '-';
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(b.description ?? 'Keine Beschreibung'),
                  subtitle: Text('${sign} ${b.amount.toStringAsFixed(0)} CHF',
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  trailing: const Icon(Icons.more_vert),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartMonth {
  final DateTime month;
  double amount;

  _ChartMonth(this.month, this.amount);
}

List<_ChartMonth> _generateMonthlyChartData(List<Booking> bookings) {
  final now = DateTime.now();
  final months = List.generate(6, (i) {
    final month = DateTime(now.year, now.month - (5 - i));
    return _ChartMonth(month, 0);
  });

  for (final booking in bookings) {
    for (final m in months) {
      if (booking.date.year == m.month.year &&
          booking.date.month == m.month.month) {
        m.amount += booking.type == BookingType.income
            ? booking.amount
            : -booking.amount;
      }
    }
  }

  return months;
}
