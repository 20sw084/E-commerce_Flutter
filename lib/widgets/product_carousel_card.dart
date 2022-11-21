import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/home_model.dart';
import 'package:tri_karo_2/views/product_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';

class ProductCarouselCard extends StatefulWidget {

  final String image;
  final String name;
  final String description;
  final String price;
  const ProductCarouselCard({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    Key? key}) : super(key: key);

  @override
  State<ProductCarouselCard> createState() => _ProductCarouselCardState();
}

class _ProductCarouselCardState extends State<ProductCarouselCard> {
  @override
  Widget build(BuildContext context) {
    //final homeData = Provider.of<HomeData>(context);
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductScreen())),
      child: Container(
          // width: 180,
          height: 285,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: black.withOpacity(0.08), blurRadius: 32, spreadRadius: -8, offset: const Offset(0, 12))]),
          child: Column(children: [
            Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                    image: DecorationImage(image:NetworkImage(widget.image), fit: BoxFit.cover))),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: black, fontSize: 16))),
            const SizedBox(height: 2),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text( widget.description, maxLines: 1, style: GoogleFonts.poppins(color: grey_2, fontSize: 12))),
            const SizedBox(height: 8),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('\$ ', maxLines: 1, style: GoogleFonts.poppins(color: red_1, fontWeight: FontWeight.w500, fontSize: 14)),
                  Text( widget.price, maxLines: 1, style: GoogleFonts.poppins(color: black, fontWeight: FontWeight.bold, fontSize: 18)),
                ])
          ])));
  }
}
