import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/filter_chip_list.dart';
import '../widgets/product_list_view.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: white,
      appBar: const CustomAppBar(title: 'Top Selling Products'),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [SizedBox(height: 8), FilterChipsList(), SizedBox(height: 16), Expanded(child: ProductListView())]));
}
