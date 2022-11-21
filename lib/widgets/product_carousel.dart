import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/home_model.dart';
import 'package:tri_karo_2/views/product_list_screen.dart';
import 'package:tri_karo_2/widgets/product_carousel_card.dart';

import '../utils/colors.dart';

class ProductCarousel extends StatelessWidget {
  final String carouselTitle;
  final Color backgroundColor;

  const ProductCarousel(
      {required this.carouselTitle, required this.backgroundColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeData>(context);
    return Container(
        color: backgroundColor,
        child: Column(children: [
          const SizedBox(height: 14),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                        child: Text(carouselTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: black,
                                fontWeight: FontWeight.w500))),
                    GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProductListScreen())),
                        child: Text('See All',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: red_1,
                                fontWeight: FontWeight.w500))),
                  ])),
          Container(
              color: white,
              height: 325,
              child: ListView.builder(
                  itemCount: homeData.topSellingProducts.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (BuildContext context, int index) {
                    return Align(
                        alignment: Alignment.topCenter,
                        // give values to product carousel card..

                        child: ProductCarouselCard(
                          image: homeData.topSellingProducts[index]["image"] ?? "",
                          name: homeData.topSellingProducts[index]["name"] ?? "",
                          description: homeData.topSellingProducts[index]["description"] != null ? homeData.topSellingProducts[index]["description"] : "",
                          price: homeData.topSellingProducts[index]["price"] ?? "",
                        ));
                  }))
        ]));
  }
}
