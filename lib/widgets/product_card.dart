import 'package:flutter/material.dart';
import 'package:quickvilla/screens/products_listing_screen.dart';
import 'package:quickvilla/services/delete_product.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;
import '../screens/product_screen.dart';
import '../utils/constants.dart';

class ProductCard extends StatefulWidget {
  final int isFeatured;
  final bool isSelectable;
  final String name;
  final String id;
  final String image;
  final String short_description;
  final String price;
  const ProductCard({
    Key? key,
    this.isSelectable = false,
    required this.isFeatured,
    required this.name,
    required this.id,
    required this.image,
    required this.short_description,
    required this.price,
  }) : super(key: key);
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isSelected = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    if(!isLoading) {
      return GestureDetector(
          onTap: () {
            if (widget.isSelectable) {
              setState(() => isSelected = !isSelected);
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductScreen(id: widget.id)));
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(color: black.withOpacity(0.02), blurRadius: 8),
                    BoxShadow(
                        color: black.withOpacity(0.05),
                        blurRadius: 32,
                        offset: const Offset(0, 12)),
                  ],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(children: [
                Stack(clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(widget.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.4)),
                      Positioned(
                        right: -10,
                        top: -10,
                        child: GestureDetector(
                            onTap: () async {
                              isLoading = true;
                              await deleteProduct(token: globals.token, id: widget.id).whenComplete(() {
                                isLoading = false;
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProductsListingScreen(heading: "All Products")));
                              });
                            },
                            child: const Icon(
                                Icons.delete_forever, color: Colors.red)),
                      ),
                      if (widget.isFeatured ==1)
                        Positioned(
                            top: 8,
                            right: 16,
                            child: Chip(
                                backgroundColor: black,
                                elevation: 0,
                                label: Text('Featured',
                                    style: TextStyle(
                                        fontSize: 12, color: white)))),
                      if (widget.isSelectable)
                        Positioned(
                          top: 8,
                          right: 16,
                          child: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                value: isSelected,
                                fillColor: MaterialStateProperty.all(
                                    isSelected ? red : Colors.grey.shade400),
                                onChanged: (value) =>
                                    setState(() => isSelected = value!),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6))),
                          ),
                        ),
                    ]),
                const SizedBox(height: 16),
                Text(widget.name.toString(),
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 26)),
                const SizedBox(height: 8),
                Text(widget.short_description,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.grey.shade600, fontSize: 14)),
                const SizedBox(height: 8),
                RichText(
                    text: TextSpan(
                        text: '\$',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: black,
                            fontSize: 22),
                        children: [
                          TextSpan(
                              text: widget.price,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: red,
                                  fontSize: 28)),
                        ])),
                const SizedBox(height: 20)
              ])));
    }
    else {
      return const CircularProgressIndicator();
    }
  }
}