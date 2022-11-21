import 'package:flutter/material.dart';
import '../../utils/colors.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  const SecondaryButton({Key? key, required this.ontap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: ontap,
      child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: white, border: Border.all(color: Colors.red, width: 1), borderRadius: BorderRadius.circular(40)),
          child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.red, fontSize: 14))));
}
