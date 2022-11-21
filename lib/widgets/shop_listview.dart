import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:tri_karo_2/widgets/shop_card.dart';

import '../models/home_model.dart';

class ShopListView extends StatelessWidget {
  const ShopListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Code to be written by Jonny
    final shopData = Provider.of<HomeData>(context);

    // return ListView.builder(
    //     itemCount: 10,
    //     padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 32),
    //     itemBuilder: (BuildContext context, int index) {
    //       Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.2);
    //       return ShopCard(color: color);
    //     });

// BY JONNY
    return ListView.builder(
      itemCount: shopData.stores.length,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 32),
      itemBuilder: (BuildContext context, int index) {
        Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(0.2);
        return ShopCard(
          cover: shopData.stores[index]["cover"],
          logo: shopData.stores[index]["logo"],
          name: shopData.stores[index]["name"],
        );
      },
    );
  }
}
