import 'dart:developer';
import 'package:flutter/material.dart';

class Variations extends ChangeNotifier {
  List<Map<String, dynamic>> variationsList = [];

  getVariantsList(dynamic varsFromApi) async {
    Map<String,dynamic> options = {};
    await varsFromApi.forEach((element) {
      options["options"] = element;
      log("this is options list: $options");
      options.update(
        "options",
        // You can ignore the incoming parameter if you want to always update the value even if it is already in the map
            (existingValue) => element,
        ifAbsent: () => element,
      );
      //variationsList.add(options);
      log("after setting option to variation list: $variationsList");
    });
    log("After calling getVariantsList: ${variationsList.toString()}");
    notifyListeners();
  }

  removeFromVariations({required int index}) {
    variationsList.removeAt(index);
    notifyListeners();
  }
}
