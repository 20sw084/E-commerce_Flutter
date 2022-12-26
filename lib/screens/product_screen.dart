import 'dart:developer';
import 'package:quickvilla/services/view_product.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;
import 'package:flutter/material.dart';
import 'package:quickvilla/widgets/color_selector.dart';
import 'package:quickvilla/widgets/size_selector.dart';
import '../utils/constants.dart';
import '../widgets/navigation_bar_vertical.dart';
import '../widgets/product_image_slider.dart';
import '../widgets/review_card.dart';

class ProductScreen extends StatefulWidget {
  final String id;

  const ProductScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  dynamic dataFuture;

  @override
  void initState() {
    super.initState();
    dataFuture = viewProduct(token: globals.token, productId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 6) * 5;
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                future: dataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    dynamic data = snapshot.data;
                    log(data.toString());
                    return Row(children: [
                      const NavigationBarVertical(
                          selectedScreen: ScreensEnum.product),
                      Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                ProductImageSlider(
                                  width: width,
                                  id: data["id"].toString(),
                                  name: data["name"],
                                  description: data["description"] ?? "N/A",
                                  short_description:
                                      data["short_description"] ?? "N/A",
                                  product_type: data["product_type"],
                                  price: data["price"],
                                  sale_price: data["sale_price"] ?? "",
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 40),
                                          Row(children: [
                                            Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: white,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            data["image"]),
                                                        fit: BoxFit.cover),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 4))),
                                            const SizedBox(width: 24),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(data["name"],
                                                      style: TextStyle(
                                                          color: black,
                                                          fontSize: 26,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                  Text(
                                                      data["description"] ?? "",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade600,
                                                          fontSize: 18))
                                                ])
                                          ]),
                                          const SizedBox(height: 32),
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.baseline,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                Text('Description',
                                                    style: TextStyle(
                                                        color: black,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                const Spacer(),
                                                Text('\$',
                                                    style: TextStyle(
                                                        color: red,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                Text(data["sale_price"] ?? "N/A",
                                                    style: TextStyle(
                                                        color: black,
                                                        fontSize: 32,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                              ]),
                                          Text(
                                              data["short_description"] ??
                                                  "N/A",
                                              style: TextStyle(
                                                  color: Colors.grey.shade600)),
                                          const SizedBox(height: 32),
                                          // Show variations only when there is data in variations list
                                          Visibility(
                                            visible: data["variations"].length != 0,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Size',
                                                    style: TextStyle(
                                                        color: black,
                                                        fontSize: 22,
                                                        fontWeight: FontWeight.w500)),
                                                const SizedBox(height: 12),
                                                    const SizeSelector(),
                                                    const SizedBox(height: 32),
                                                    Text('Colors',
                                                        style: TextStyle(
                                                            color: black,
                                                            fontSize: 22,
                                                            fontWeight: FontWeight.w500)),
                                                    const SizedBox(height: 12),
                                                    const ColorSelector(),
                                                    const SizedBox(height: 32),
                                              ],
                                            ),
                                          ),
                                          Text('Reviews',
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500)),
                                          const SizedBox(height: 24),
                                          ListView.builder(
                                              itemCount: data["reviews"].length == 0 ? data["reviews"].length + 1 : data["reviews"].length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                if (data["reviews"].length ==
                                                    0) {
                                                  return const Text(
                                                      "No reviews on this product yet");
                                                } else {
                                                  return const ReviewCard();
                                                }
                                              }),
                                        ]))
                              ])))
                    ]);
                  } else {
                    return const Center(child: Text("Theres no data"));
                  }
                })));
  }
}
