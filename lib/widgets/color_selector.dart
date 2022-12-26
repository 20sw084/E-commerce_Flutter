import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickvilla/models/attribute_model.dart';
import 'package:quickvilla/services/get_attributes.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;

import '../utils/constants.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({Key? key}) : super(key: key);
  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  int selectedColorIndex = 0;
  List<Color> colorsList = [
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.blue,
    Colors.black,
    Colors.brown,
    Colors.white
  ];

  late Future<dynamic> futureAttrList;

  @override
  void initState() {
    // TODO: implement initState
    futureAttrList = getAttributesFromApi(token: globals.token);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: colorsList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () => setState(() => selectedColorIndex = index),
            child: AnimatedContainer(
              height: index == selectedColorIndex ? 36 : 28,
              width: index == selectedColorIndex ? 36 : 28,
              margin: EdgeInsets.only(top: index == selectedColorIndex ? 0 : 12, bottom: index == selectedColorIndex ? 4 : 0, right: 8),
              decoration: BoxDecoration(
                  color: colorsList[index],
                  border: Border.all(color: black, width: index == selectedColorIndex ? 4 : 1),
                  borderRadius: BorderRadius.circular(24)),
              duration: const Duration(milliseconds: 300),
              // child: Icon(Icons.check, color: index == selectedColorIndex ? Colors.grey.shade300 : Colors.grey.shade300.withOpacity(0)),
            )))
      /*FutureBuilder(
        future: futureAttrList,
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: colorsList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () => setState(() => selectedColorIndex = index),
                  child: AnimatedContainer(
                    height: index == selectedColorIndex ? 36 : 28,
                    width: index == selectedColorIndex ? 36 : 28,
                    margin: EdgeInsets.only(top: index == selectedColorIndex ? 0 : 12, bottom: index == selectedColorIndex ? 4 : 0, right: 8),
                    decoration: BoxDecoration(
                        color: colorsList[index],
                        border: Border.all(color: black, width: index == selectedColorIndex ? 4 : 1),
                        borderRadius: BorderRadius.circular(24)),
                    duration: const Duration(milliseconds: 300),
                    // child: Icon(Icons.check, color: index == selectedColorIndex ? Colors.grey.shade300 : Colors.grey.shade300.withOpacity(0)),
                  )));
        }
      )*/
    );
  }
}

class MultiColorSelector extends StatefulWidget {
  const MultiColorSelector({Key? key}) : super(key: key);
  @override
  State<MultiColorSelector> createState() => _MultiColorSelectorState();
}

class _MultiColorSelectorState extends State<MultiColorSelector> {
  int selectedColorIndex = 0;

  List<Color> colorsList = [
        Colors.green,
        Colors.lightGreen,
        Colors.lime,
        Colors.yellow,
        Colors.amber,
        Colors.orange,
        Colors.red,
        Colors.pink,
        Colors.purple,
        Colors.indigo,
        Colors.blue,
        Colors.lightBlue,
        Colors.cyan,
        Colors.blue,
        Colors.black,
        Colors.brown,
        Colors.white
      ],



      selectedColorsList = [];
  @override
  Widget build(BuildContext context) {
    final attributeProvider = Provider.of<Attribute>(context);
    log(attributeProvider.attributeList.toString());
    return SizedBox(
      height: 40,
      child:
      ListView.builder(
          itemCount: colorsList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () => setState(() => selectedColorsList.contains(colorsList[index])
                  ? selectedColorsList.remove(colorsList[index])
                  : selectedColorsList.add(colorsList[index])),
              child: AnimatedContainer(
                  height: selectedColorsList.contains(colorsList[index]) ? 36 : 28,
                  width: selectedColorsList.contains(colorsList[index]) ? 36 : 28,
                  margin: EdgeInsets.only(
                      top: selectedColorsList.contains(colorsList[index]) ? 0 : 12,
                      bottom: selectedColorsList.contains(colorsList[index]) ? 4 : 0,
                      right: 8),
                  decoration: BoxDecoration(
                      color: colorsList[index],
                      border: Border.all(color: black, width: selectedColorsList.contains(colorsList[index]) ? 4 : 1),
                      borderRadius: BorderRadius.circular(24)),
                  duration: const Duration(milliseconds: 300))))
    );
  }
}
