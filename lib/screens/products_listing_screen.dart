import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickvilla/screens/featured_products_listing_screen.dart';
import 'package:quickvilla/services/get_categories.dart';
import 'package:quickvilla/services/products.dart';
import 'package:quickvilla/widgets/products_listview.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;
import '../utils/constants.dart';
import '../widgets/navigation_bar_vertical.dart';
import '../widgets/text_input_decoration.dart';

class ProductsListingScreen extends StatefulWidget {
  final String heading;
  const ProductsListingScreen({Key? key, required this.heading})
      : super(key: key);
  @override
  State<ProductsListingScreen> createState() => _ProductsListingScreenState();
}

class _ProductsListingScreenState extends State<ProductsListingScreen> {
  String selectedCategory = '';

  List<dynamic> categories = [];

  getCategories() async {
    await getCategoriesFromApi(token: globals.token).then((value) {
      setState(() {
        categories = value;
        selectedCategory = categories[0]["id"].toString();
      });
    });
  }


  late Future<dynamic> dataFuture;

  @override
  void initState() {
    super.initState();
    getCategories();
    dataFuture =
        myProducts(token: globals.token);
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
                  //dynamic data = snapshot.data;
                  return Row(children: [
                    const NavigationBarVertical(
                        selectedScreen: ScreensEnum.store),
                    Expanded(
                        flex: 5,
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 24),
                                        IconButton(
                                            onPressed: () => Navigator.pop(context),
                                            icon: const Icon(Icons.arrow_back),
                                            iconSize: 32),
                                        const SizedBox(width: 32),
                                        Text(widget.heading,
                                            style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w500)),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                  const FeaturedProductsListingScreen())),
                                          child: Container(
                                              margin:
                                              const EdgeInsets.only(right: 24),
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 25),
                                              decoration: BoxDecoration(
                                                  color: red,
                                                  borderRadius:
                                                  BorderRadius.circular(40)),
                                              child: Text('Featured Products',
                                                  style: TextStyle(
                                                      color: white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16))),
                                        ),
                                      ]),
                                  const SizedBox(height: 24),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: TextField(
                                                  decoration: textInputDecoration(
                                                      label: 'Search Products',
                                                      prefixIcon:
                                                      CupertinoIcons.search),
                                                )),
                                            const SizedBox(width: 18),
                                            Expanded(
                                                child: Container(
                                                    padding: const EdgeInsets.only(
                                                        right: 12, left: 16),
                                                    decoration: BoxDecoration(
                                                        color: const Color(0xffF0F0F0),
                                                        borderRadius:
                                                        BorderRadius.circular(12)),
                                                    height: 50,
                                                    alignment: Alignment.center,
                                                    child: DropdownButton<String>(
                                                      value: selectedCategory,
                                                      onChanged: (value) => setState(() =>
                                                      selectedCategory = value.toString()),
                                                      iconEnabledColor: red,
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      isExpanded: true,
                                                      underline: const SizedBox.shrink(),
                                                      style: TextStyle(
                                                          color: Colors.grey.shade700),
                                                      items: categories
                                                          .map((val) => DropdownMenuItem<String>(
                                                          value: val["id"].toString(),
                                                          child: Text(val["name"]??"")))
                                                          .toList(),
                                                    )
                                                ))
                                          ])),
                                  const ProductsListing(),
                                ]))),
                  ]);
                } else {
                  return const Center(child: Text("Theres no data"));
                }
              })));
}