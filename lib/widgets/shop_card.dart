import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../views/shop_screen.dart';

class ShopCard extends StatelessWidget {
  // final Color color;
  final String cover;
  final String logo;
  final String name;
  const ShopCard(
      {required this.cover, required this.logo, required this.name, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShopScreen(cover, logo, name),
          ),
        ),
        child: Stack(alignment: Alignment.topCenter, children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16, top: 45),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(cover), fit: BoxFit.cover),
                color: Colors.white,
                borderRadius: BorderRadius.circular(16)),
            child: Container(
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: white, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 50),
                  Text(name,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                          color: black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      const Icon(EvaIcons.star, color: Colors.orange, size: 18),
                      Text('  4.8',
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              color: Colors.orange,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                      Text('   (490 Ratings)    |    Men Fashion',
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              color: grey_2,
                              fontSize: 12,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ],
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: white,
            radius: 55,
            child: Container(
              width: 110,
              height: 110,
              padding: const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ]),
      );
}
