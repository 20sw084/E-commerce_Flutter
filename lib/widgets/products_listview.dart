import 'dart:developer';
import 'package:quickvilla/utils/global_variables.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quickvilla/services/products.dart';
import 'package:quickvilla/widgets/product_card.dart';

class ProductsListing extends StatefulWidget {
  const ProductsListing({Key? key}) : super(key: key);

  @override
  State<ProductsListing> createState() => _ProductsListingState();
}

class _ProductsListingState extends State<ProductsListing> {
  dynamic dataFuture;
  @override
  void initState() {
    super.initState();
    dataFuture = myProducts(token: globals.token);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          dynamic data = snapshot.data;
          return AlignedGridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              crossAxisCount: 2,
              itemCount: data.length,
              shrinkWrap: true,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ProductCard(
                  isFeatured:  data[index]["is_store_featured"] ?? 0,
                  name: data[index]["name"] ?? "Null",
                  image: data[index]["image"],
                  short_description: data[index]["short_description"] ?? "",
                  price: data[index]["sale_price"] ?? "",
                  id: data[index]["id"].toString(),
              ));
        } else {
          return const Center(child: Text("Theres no data"));
        }
      });
}
