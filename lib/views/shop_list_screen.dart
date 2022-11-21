import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/filter_chip_list.dart';
import '../widgets/shop_listview.dart';

class ShopListScreen extends StatefulWidget {
  const ShopListScreen({Key? key}) : super(key: key);
  @override
  State<ShopListScreen> createState() => _ShopListScreenState();
}

class _ShopListScreenState extends State<ShopListScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: white,
      appBar: const CustomAppBar(title: 'All Stores'),
      body: Column(mainAxisSize: MainAxisSize.min, children: const [
        // SafeArea(child: SizedBox()),
        SizedBox(height: 8),
        FilterChipsList(),
        SizedBox(height: 16),
        Expanded(child: ShopListView())
      ]));
}
