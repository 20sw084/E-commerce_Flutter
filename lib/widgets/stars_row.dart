import 'package:flutter/material.dart';

class StarsRow extends StatelessWidget {
  final int total, highlighted;
  final double iconSize;
  const StarsRow({Key? key, required this.total, required this.highlighted, this.iconSize = 18}) : super(key: key);
  @override
  Widget build(BuildContext context) => SizedBox(
      height: iconSize,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: total,
          itemBuilder: (context, index) =>
              Icon(index < highlighted ? Icons.star : Icons.star_border_rounded, color: Colors.amber.shade700, size: iconSize)));
}
