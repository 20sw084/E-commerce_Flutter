import 'dart:developer';
import 'package:quickvilla/utils/global_variables.dart' as globals;

import 'package:flutter/material.dart';
import 'package:quickvilla/screens/products_listing_screen.dart';
import 'package:quickvilla/screens/store_edit_screen.dart';
import 'package:quickvilla/services/mystore.dart';
import 'package:quickvilla/widgets/stars_row.dart';
import '../utils/constants.dart';
import '../widgets/navigation_bar_vertical.dart';
import '../widgets/products_listview.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  dynamic dataFuture;
  @override
  void initState() {
    super.initState();
    dataFuture = mystore(token: globals.token);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
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
                  log(data["description"]);
                  return Row(children: [
                    const NavigationBarVertical(
                        selectedScreen: ScreensEnum.store),
                    Expanded(
                        flex: 5,
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              SizedBox(
                                  height: 350,
                                  child: Stack(children: [
                                    Image.network(data["cover"],
                                        height: 250,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const StoreEditScreen())),
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 40, right: 24),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 32),
                                              decoration: BoxDecoration(
                                                  color: red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: Text('Edit',
                                                  style: TextStyle(
                                                      color: white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16))),
                                        )),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                  width: 200,
                                                  height: 200,
                                                  margin: const EdgeInsets.only(
                                                      left: 24),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: white,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              data["logo"]),
                                                          fit: BoxFit.cover),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300,
                                                          width: 6))),
                                              // const SizedBox(width: 34),
                                              const Spacer(),

                                              Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Text('100+',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 32)),
                                                    Text('Products',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors
                                                                .grey.shade700))
                                                  ]),
                                              const Spacer(flex: 2),
                                              Container(
                                                  width: 2,
                                                  height: 70,
                                                  color: Colors.grey.shade300),
                                              const Spacer(flex: 2),
                                              Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: const [
                                                    Text('Reviews',
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 32)),
                                                    SizedBox(height: 4),
                                                    StarsRow(
                                                        total: 5,
                                                        highlighted: 4),
                                                    SizedBox(height: 4),
                                                  ]),
                                              const Spacer(flex: 2),
                                            ])),
                                  ])),
                              const SizedBox(height: 40),
                              const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  child: Text('Description',
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22))),
                              const SizedBox(height: 18),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Text(data["description"],
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 18))),
                              const SizedBox(height: 40),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        const Text('Products',
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 22)),
                                        GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ProductsListingScreen(
                                                            heading:
                                                                'All Products'))),
                                            child: Text('View All',
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: red,
                                                    fontSize: 16)))
                                      ])),
                              const ProductsListing(),
                            ])))
                  ]);
                } else {
                  return const Center(child: Text("Theres no data"));
                }
              })));
}
