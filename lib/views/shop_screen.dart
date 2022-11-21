import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tri_karo_2/views/product_list_screen.dart';
import '../utils/colors.dart';
import '../utils/constant_variables.dart';
import '../widgets/product_list_view.dart';
import '../widgets/shop_carousel.dart';

String ccover = "";
String llogo = "";
String nname = "";

class ShopScreen extends StatefulWidget {
  // const ShopScreen({Key? key}) : super(key: key);
  ShopScreen(String c, String l, String n) {
    ccover = c;
    llogo = l;
    nname = n;
  }
  // const ShopScreen({this.ccover, this.llogo, this.nname, Key? key})
  //     : super(key: key);
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  double carouselHeight = 0.0;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: white,
      body: Stack(children: [
        NestedScrollView(
            // controller: cont.scrollController,
            headerSliverBuilder: (context, isOk) => [
                  SliverAppBar(
                    centerTitle: true,
                    expandedHeight: MediaQuery.of(context).size.height * 0.3,
                    backgroundColor: black,
                    elevation: 0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(ccover, fit: BoxFit.cover),
                      // background: Image.asset(ccover, fit: BoxFit.cover),
                      stretchModes: const [
                        StretchMode.zoomBackground,
                        StretchMode.fadeTitle
                      ],
                      expandedTitleScale: 3,
                      centerTitle: true,
                      title: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                llogo,
                              ),
                              // AssetImage(
                              //     '$imagePath/sample_shop_image.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ],
            body: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification is UserScrollNotification) {
                  // if (cont.scrollController.offset < 150 && cont.carouselHeight != 0) {
                  //   cont.carouselHeight = 0;
                  //   cont.update();
                  // }
                  if (notification.direction == ScrollDirection.forward &&
                      carouselHeight != 244) {
                    setState(() => carouselHeight = 244);
                  }
                  notification.metrics.pixels < 1;
                  if (notification.direction == ScrollDirection.reverse &&
                      carouselHeight != 0) {
                    carouselHeight = 0;
                    setState(() => carouselHeight = 0);
                  }
                }
                return false;
              },
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  // controller: cont.scrollController,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(height: 56, width: 1, color: transparent),
                            Column(children: [
                              Text('100+',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: black,
                                      fontWeight: FontWeight.w600)),
                              Text('Products',
                                  style: GoogleFonts.poppins(color: grey_1)),
                            ]),
                            Container(height: 56, width: 1, color: grey_3),
                            Column(children: [
                              Text('Reviews',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: black,
                                      fontWeight: FontWeight.w600)),
                              Row(children: [
                                const Icon(Icons.star,
                                    size: 16, color: Colors.orange),
                                const Icon(Icons.star,
                                    size: 16, color: Colors.orange),
                                const Icon(Icons.star,
                                    size: 16, color: Colors.orange),
                                const Icon(Icons.star,
                                    size: 16, color: Colors.orange),
                                Icon(Icons.star_outline,
                                    size: 16, color: grey_4),
                              ])
                            ]),
                            Container(height: 56, width: 1, color: transparent),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Description',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: black,
                                    fontWeight: FontWeight.w500))),
                        const SizedBox(height: 12),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text.',
                                style: GoogleFonts.poppins(color: grey_1))),
                        const SizedBox(height: 14),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Expanded(
                                      child: Text('Top Selling products',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
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
                        const ProductListView(
                            physics: NeverScrollableScrollPhysics()),
                        const SizedBox(height: 36),
                      ])),
            )),
        Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: carouselHeight,
                child: Wrap(children: const [NearbyShopCarousel()]))),
      ]));
}
