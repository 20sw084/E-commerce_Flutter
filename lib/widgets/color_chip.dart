import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ColorChip extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorChip(this.color, {this.isSelected = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 8),
      decoration:
          BoxDecoration(color: color, border: Border.all(color: isSelected ? black : grey_5, width: 3), borderRadius: BorderRadius.circular(25)),
      child: Icon(Icons.check, color: white, size: 20));
}
