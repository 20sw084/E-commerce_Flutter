import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/home_model.dart';
import 'package:tri_karo_2/views/shop_list_screen.dart';
import 'package:tri_karo_2/widgets/shop_carousel_card.dart';
import '../utils/colors.dart';

class ShopCarousel extends StatelessWidget {
  const ShopCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeData>(context);
    return Container(
        color: grey_3.withOpacity(0.25),
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
                        child: Text('All Stores',
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
                                builder: (context) => const ShopListScreen())),
                        child: Text('See All',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: red_1,
                                fontWeight: FontWeight.w500)))
                  ])),
          SizedBox(
            height: 210,
            child: ListView.builder(
              itemCount: homeData.stores.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (BuildContext context, int index) => Align(
                alignment: Alignment.topCenter,
                // stores data
                //cover, logo, title
                child: ShopCarouselCard(
                  homeData.stores[index]["cover"],
                  homeData.stores[index]["logo"],
                  homeData.stores[index]["name"],
                ),
              ),
            ),
          )
        ]));
  }
}

class NearbyShopCarousel extends StatelessWidget {
  const NearbyShopCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
      color: grey_5,
      child: Column(children: [
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                      child: Text('Nearby Shops',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w600))),
                  GestureDetector(
                      // onTap: () => Get.toNamed(kShopListScreen),
                      onTap: () {},
                      child: Text('See All',
                          style: GoogleFonts.poppins(
                              color: red_1, fontWeight: FontWeight.w500)))
                ])),
        SizedBox(
            height: 140,
            child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (BuildContext context, int index) => const Align(
                    alignment: Alignment.topCenter,
                    child: MiniShopCarouselCard()))),
        const SizedBox(height: 40),
      ]));
}
