import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const PrimaryButton({Key? key, required this.text, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        splashColor: white.withOpacity(0.35),
        focusColor: white.withOpacity(0.35),
        hoverColor: white.withOpacity(0.35),
        overlayColor: MaterialStateProperty.all(white.withOpacity(0.35)),
        highlightColor: white.withOpacity(0.35),
        child: Ink(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: red,
                boxShadow: [BoxShadow(color: red.withOpacity(0.4), offset: const Offset(0, 20), spreadRadius: -10, blurRadius: 24)]),
            child: Center(child: Text(text, style: TextStyle(fontSize: 18, color: white)))));
  }
}
