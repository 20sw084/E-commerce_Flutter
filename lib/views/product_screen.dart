import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tri_karo_2/views/cart_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/color_chip.dart';
import '../widgets/comment_card.dart';
import '../widgets/primary_button.dart';
import '../widgets/size_chip.dart';
import '../widgets/star_button.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          elevation: 0,
          backgroundColor: transparent,
          foregroundColor: white),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              PrimaryButton(ontap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen())), text: 'Add to cart')),
      body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
        Stack(alignment: Alignment.bottomCenter, children: [
          Image.asset('$imagePath/sample_product_photo.jpeg',
              fit: BoxFit.cover, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height / 2),
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: const [0, 0.4, 0.8, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [black.withOpacity(0.75), black.withOpacity(0), black.withOpacity(0), black.withOpacity(0.25)]))),
          Positioned(
              bottom: 16,
              child: Row(children: const [
                SliderDot(isSelected: true),
                SliderDot(),
                SliderDot(),
                SliderDot(),
                SliderDot(),
              ]))
        ]),
        const SizedBox(height: 32),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Knitted Sweater', style: GoogleFonts.poppins(fontSize: 24, color: black, fontWeight: FontWeight.w600))),
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('$imagePath/sample_shop_image.jpg')),
                      border: Border.all(color: Colors.grey.shade200, width: 4),
                      borderRadius: BorderRadius.circular(25))),
              const SizedBox(width: 12),
              Text('Chanel', style: GoogleFonts.poppins(fontSize: 16, color: black, fontWeight: FontWeight.w600))
            ])),
        const SizedBox(height: 32),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Description', style: GoogleFonts.poppins(fontSize: 16, color: black, fontWeight: FontWeight.w600))),
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text.',
                style: GoogleFonts.poppins(color: grey_2))),
        const SizedBox(height: 28),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Size', style: GoogleFonts.poppins(fontSize: 16, color: black, fontWeight: FontWeight.w600))),
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(children: const [SizeChip('XS', isSelected: true), SizeChip('S'), SizeChip('m'), SizeChip('l'), SizeChip('Xl')])),
        const SizedBox(height: 28),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Colors', style: GoogleFonts.poppins(fontSize: 16, color: black, fontWeight: FontWeight.w600))),
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(children: const [
              ColorChip(Colors.red, isSelected: true),
              ColorChip(Colors.black),
              ColorChip(Colors.blue),
              ColorChip(Colors.green),
              ColorChip(Colors.cyan)
            ])),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 24),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                const Icon(EvaIcons.star, color: Colors.orange, size: 18),
                const SizedBox(width: 8),
                Text('4.8', style: GoogleFonts.poppins(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Text('(490 reviews)', style: GoogleFonts.poppins(color: grey_2, fontSize: 16, fontWeight: FontWeight.w500)),
              ]),
              Text('See all', style: GoogleFonts.poppins(color: red_1, fontWeight: FontWeight.w500)),
            ])),
        const SizedBox(height: 32),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(children: const [
                  StarButton(text: '1', isSelected: true),
                  SizedBox(width: 10),
                  StarButton(text: '2'),
                  SizedBox(width: 10),
                  StarButton(text: '3'),
                  SizedBox(width: 10),
                  StarButton(text: '4'),
                  SizedBox(width: 10),
                  StarButton(text: '5'),
                ]))),
        const SizedBox(height: 32),
        const CommentCard(),
        const CommentCard(),
        const CommentCard(),
        const CommentCard(),
        const SizedBox(height: 48),
      ])));
}

class SliderDot extends StatelessWidget {
  final bool isSelected;
  const SliderDot({this.isSelected = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 8,
      height: 8,
      duration: const Duration(microseconds: 300),
      decoration: BoxDecoration(
          color: isSelected ? white : transparent, shape: BoxShape.circle, border: Border.all(color: isSelected ? transparent : white, width: 1.5)));
}
