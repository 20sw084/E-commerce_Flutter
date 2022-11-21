import 'dart:ui';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/home_model.dart';
import 'package:tri_karo_2/views/shop_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';

String cccover = "";
String lllogo = "";
String nnname = "";

class ShopCarouselCard extends StatefulWidget {
  ShopCarouselCard(String c, String l, String n) {
    cccover = c;
    lllogo = l;
    nnname = n;
  }
  @override
  State<ShopCarouselCard> createState() => _ShopCarouselCardState();
}

class _ShopCarouselCardState extends State<ShopCarouselCard> {
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShopScreen(cccover, lllogo, nnname))),
        child: Container(
          width: 180,
          height: 170,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: black.withOpacity(0.08),
                    blurRadius: 32,
                    spreadRadius: -8,
                    offset: const Offset(0, 12))
              ]),
          child: Column(
            children: [
              Stack(alignment: Alignment.bottomCenter, children: [
                Container(
                    height: 77,
                    width: 172,
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6)),
                        image: DecorationImage(
                            image: NetworkImage(cccover), fit: BoxFit.cover))),
                Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,
                        border: Border.all(color: grey_5, width: 4),
                        image: DecorationImage(
                            image: NetworkImage(lllogo), fit: BoxFit.contain)))
              ]),
              const SizedBox(height: 2),
              Text(nnname,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, color: black, fontSize: 16)),
              const SizedBox(height: 2),
              RatingBar(
                initialRating: 3,
                direction: Axis.horizontal,
                itemSize: 10,
                allowHalfRating: false,
                ignoreGestures: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                    full:
                        const Icon(EvaIcons.star, color: Colors.amber, size: 7),
                    half: const Icon(EvaIcons.starOutline,
                        color: Colors.amber, size: 7),
                    empty: const Icon(EvaIcons.starOutline,
                        color: Colors.amber, size: 7)),
                itemPadding: EdgeInsets.zero,
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
        ),
      );
}

class MiniShopCarouselCard extends StatelessWidget {
  const MiniShopCarouselCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeData = Provider.of<HomeData>(context);

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShopScreen(cccover, lllogo, nnname))),
      child: Container(
          width: 240,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('$imagePath/sample_shop_cover_image.jpg'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            white.withOpacity(0.35),
                            white.withOpacity(0.7)
                          ], stops: const [
                            0,
                            0.35
                          ]),
                          borderRadius: BorderRadius.circular(6)),
                      child: Row(children: [
                        CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                AssetImage('$imagePath/sample_shop_image.jpg')),
                        const SizedBox(width: 16),
                        Expanded(
                            child: Text('Chanel.\nPakistan Chapter',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                    height: 1.2)))
                      ]))))),
    );
  }
}
