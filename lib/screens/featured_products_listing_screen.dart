import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickvilla/widgets/featured_products_listview.dart';
import 'package:quickvilla/widgets/text_input_decoration.dart';
import '../utils/constants.dart';
import '../widgets/navigation_bar_vertical.dart';

class FeaturedProductsListingScreen extends StatefulWidget {
  const FeaturedProductsListingScreen({Key? key}) : super(key: key);
  @override
  State<FeaturedProductsListingScreen> createState() => _FeaturedProductsListingScreenState();
}

class _FeaturedProductsListingScreenState extends State<FeaturedProductsListingScreen> {
  String selectedCategory = 'Hoodies';
  List<String> categories = ['Hoodies', 'T Shirts', 'Pents', 'Formal Shirts', 'Sweaters'];

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
              body: Row(children: [
        const NavigationBarVertical(selectedScreen: ScreensEnum.store),
        Expanded(
            flex: 5,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        const Text('Featured Products', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: CircleAvatar(backgroundColor: red, foregroundColor: white, child: const Icon(Icons.close, size: 32))),
                      ]),
                      const SizedBox(height: 24),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(
                            flex: 7,
                            child: TextField(
                              decoration: textInputDecoration(label: 'Search Products', prefixIcon: CupertinoIcons.search),
                            )),
                        const SizedBox(width: 18),
                        Expanded(
                            flex: 4,
                            child: Container(
                                padding: const EdgeInsets.only(right: 12, left: 16),
                                decoration: BoxDecoration(color: const Color(0xffF0F0F0), borderRadius: BorderRadius.circular(12)),
                                height: 50,
                                alignment: Alignment.center,
                                child: DropdownButton<String>(
                                    value: selectedCategory,
                                    onChanged: (value) => setState(() => selectedCategory = value.toString()),
                                    iconEnabledColor: red,
                                    borderRadius: BorderRadius.circular(10),
                                    isExpanded: true,
                                    underline: const SizedBox.shrink(),
                                    style: TextStyle(color: Colors.grey.shade700),
                                    items: categories.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList())))
                      ]),
                      const FeaturedProductsListing()
                    ]))))
      ])));
}
