import 'package:flutter/material.dart';

import '../screens/product_edit_screen.dart';
import '../utils/constants.dart';

class ProductImageSlider extends StatefulWidget {
  final double width;
  final String name;
  final String description;
  final String short_description;
  final String product_type;
  final String sale_price;
  final String price;
  final String id;

  const ProductImageSlider({
    Key? key,
    required this.width,
    required this.name,
    required this.description,
    required this.short_description,
    required this.product_type,
    required this.price,
    required this.sale_price,
    required this.id,
  }) : super(key: key);
  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int selectedImageIndex = 0;
  int imageCount = 10;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: widget.width + 50,
      width: widget.width,
      child: Stack(children: [
        PageView.builder(
            onPageChanged: (value) =>
                setState(() => selectedImageIndex = value),
            scrollDirection: Axis.horizontal,
            itemCount: imageCount,
            itemBuilder: (BuildContext context, int index) => Image.asset(
                '$imagePath/sample_product_image.jpg',
                fit: BoxFit.cover)),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          black.withOpacity(0),
                          black.withOpacity(0.25)
                        ])),
                height: 46,
                child: ListView.builder(
                    itemCount: imageCount,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) =>
                        AnimatedContainer(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 16),
                            duration: const Duration(milliseconds: 400),
                            width: selectedImageIndex == index ? 14 : 10,
                            height: selectedImageIndex == index ? 14 : 10,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: selectedImageIndex == index
                                        ? white
                                        : white.withOpacity(0.4),
                                    width: selectedImageIndex == index ? 7 : 2),
                                shape: BoxShape.circle))))),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              iconSize: 56,
              icon: CircleAvatar(
                  backgroundColor: black.withOpacity(0.25),
                  foregroundColor: white,
                  child: const Icon(Icons.arrow_back, size: 24))),
          GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProductScreen(
                        id: widget.id,
                        name: widget.name,
                        description: widget.description,
                        shortDescription: widget.short_description,
                        productType: widget.product_type,
                        price: widget.price,
                        salePrice: widget.sale_price,
                      ))),
              child: Container(
                  height: 40,
                  margin: const EdgeInsets.only(right: 24),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: red,
                      boxShadow: [
                        BoxShadow(
                            color: red.withOpacity(0.4),
                            offset: const Offset(0, 20),
                            spreadRadius: -10,
                            blurRadius: 24)
                      ]),
                  alignment: Alignment.center,
                  child: Text('Edit',
                      style: TextStyle(color: white, fontSize: 16))))
        ])
      ]));
}