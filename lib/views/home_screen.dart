import 'dart:developer';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tri_karo_2/models/home_model.dart';
import 'package:tri_karo_2/models/user_model.dart';
import 'package:tri_karo_2/services/home.dart';
import 'package:tri_karo_2/views/delivery_screen.dart';
import 'package:tri_karo_2/views/search_screen.dart';
import 'package:tri_karo_2/views/shop_list_screen.dart';
import 'package:tri_karo_2/views/wrapper.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/menu_card.dart';
import '../widgets/dashboard_top_card.dart';
import '../widgets/product_carousel.dart';
import '../widgets/shop_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> userMap = {};
  final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final homeData = Provider.of<HomeData>(context);
    userMap = user.toJson();
    return Scaffold(
        key: _homeKey,
        backgroundColor: white,
        appBar: _buildAppBar(() {
          _homeKey.currentState!.openEndDrawer();
        }),
        endDrawer: Drawer(
            backgroundColor: white,
            child: Column(children: [
              const SizedBox(height: 64),
              Stack(alignment: Alignment.bottomRight, children: [
                CircleAvatar(
                    radius: 63,
                    backgroundColor: grey_5,
                    backgroundImage:
                        AssetImage('$imagePath/empty_profile_image.png')),
                Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: red_1, borderRadius: BorderRadius.circular(8)),
                    child: Icon(EvaIcons.editOutline, color: white))
              ]),
              const SizedBox(height: 16),
              Text('Andrew Ainsley',
                  style: GoogleFonts.poppins(
                      color: black, fontSize: 24, fontWeight: FontWeight.w500)),
              Text('andrew.ainsley@gmail.com',
                  style: GoogleFonts.poppins(color: black, fontSize: 14)),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 20),
              menuCard('Profile', EvaIcons.personOutline),
              menuCard('Orders', Icons.storefront_outlined),
              menuCard('Cart', EvaIcons.shoppingCartOutline),
              menuCard('Address', Icons.place_outlined),
              menuCard('Settings', EvaIcons.settingsOutline),
              GestureDetector(
                  onTap: () async {
                    await user.removeUser("user");
                    if (!mounted) return;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Wrapper()));
                  },
                  child: menuCard('Logout', EvaIcons.logOutOutline)),
            ])),
        body: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 16),
          GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchScreen())),
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: grey_5, borderRadius: BorderRadius.circular(8)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(EvaIcons.search),
                              color: grey_2.withOpacity(0.7)),
                          Text('Search',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: grey_2.withOpacity(0.75))),
                        ]),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(EvaIcons.options2Outline),
                            color: red_2,
                            iconSize: 20),
                      ]))),
          const SizedBox(height: 24),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(children: [
                DashobardTopCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeliveryScreen()));
                    },
                    title: 'Fast Delivery',
                    image: 'fast_delivery_image.png',
                    color: const Color(0xffD6E7FC)),
                const SizedBox(width: 16),
                DashobardTopCard(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopListScreen())),
                    title: 'All Stores',
                    image: 'all_stores_image.png',
                    color: const Color(0xffFDE2C0)),
              ])),
          const SizedBox(height: 36),
          FutureBuilder(
              future: getHomeDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  dynamic data = snapshot.data;
                  homeData.fromJson(data);
                  // homeData.stores;
                  // homeData.featuredProducts;
                  // homeData.topSellingProducts;
                  log(data.toString());
                  return Column(
                    children: [
                      const ShopCarousel(),
                      ProductCarousel(
                          carouselTitle: 'Top Selling Products',
                          backgroundColor: white),
                      ProductCarousel(
                          carouselTitle: 'Featured products',
                          backgroundColor: grey_3.withOpacity(0.25)),
                    ],
                  );
                } else if (snapshot.connectionState ==
                        ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ])));
  }

  AppBar _buildAppBar(VoidCallback onTap) => AppBar(
      backgroundColor: white,
      foregroundColor: black,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 80.0,
      actions: [
        IconButton(onPressed: onTap, icon: const Icon(EvaIcons.menu2Outline))
      ],
      leading: Container(
          width: 64,
          height: 64,
          margin: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('$imagePath/sample_user_image.png')))),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(userMap["name"] ?? "",
            style: GoogleFonts.poppins(
                color: black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.5)),
        Row(children: [
          Text(userMap["address"] ?? "",
              style:
                  GoogleFonts.poppins(color: grey_1, height: 1, fontSize: 14)),
          Icon(EvaIcons.arrowIosDownward, size: 16, color: grey_1)
        ]),
      ]));
}
