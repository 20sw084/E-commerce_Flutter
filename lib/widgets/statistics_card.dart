import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  final String text1, text2, text3;
  final Color color;
  const StatisticsCard({Key? key, required this.text1, required this.text2, required this.text3, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
      child: Container(
          height: 140,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(text1, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 34)),
            const SizedBox(height: 4),
            Text(text2, maxLines: 1, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Text(text3, maxLines: 1, style: const TextStyle(fontSize: 12)),
          ])));
}
