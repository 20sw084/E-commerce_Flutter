import 'package:flutter/material.dart';

class Attribute extends ChangeNotifier{
  List<dynamic>? attributeList;

  getAttributeList(dynamic data) async {
    attributeList = await data;
    notifyListeners();
  }

  removeElementFromList(dynamic item) {
    attributeList!.remove(item);
    notifyListeners();
  }
}
