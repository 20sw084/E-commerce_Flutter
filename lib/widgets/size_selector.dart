import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({Key? key}) : super(key: key);
  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  List<String> sizesList = ['XS', 'S', 'M', 'L', 'XL'];
  int selectedSizeIndex = 0;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 40,
      child: ListView.builder(
          itemCount: sizesList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => setState(() => selectedSizeIndex = index),
              child: AnimatedContainer(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: white,
                      border:
                          Border.all(color: index == selectedSizeIndex ? black : black.withOpacity(0.25), width: index == selectedSizeIndex ? 3 : 2),
                      borderRadius: BorderRadius.circular(24)),
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  child: Text(sizesList[index], style: TextStyle(color: black, fontSize: 18, fontWeight: FontWeight.w600))))));
}
