import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickvilla/models/user_model.dart';
import 'package:quickvilla/screens/add_attribute_option_screen.dart';
import 'package:quickvilla/screens/add_product_screen.dart';
import 'package:quickvilla/screens/home_screen.dart';
import 'package:quickvilla/screens/products_listing_screen.dart';
import 'package:quickvilla/screens/reviews_screen.dart';
import 'package:quickvilla/screens/store_screen.dart';
import '../screens/orders_listing_screen.dart';
import '../utils/constants.dart';

class NavigationBarVertical extends StatelessWidget {
  final ScreensEnum selectedScreen;

  const NavigationBarVertical({Key? key, required this.selectedScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Expanded(
      flex: 1,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.16,
          height: MediaQuery.of(context).size.height,
          color: redDark,
          child: SingleChildScrollView(
              child: Column(children: [
            const SizedBox(height: 60),
            Image.asset('$imagePath/logo_icon.png', width: 90),
            const SizedBox(height: 30),
            button(
                text: 'Dashboard',
                icon: Icons.space_dashboard_outlined,
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen())),
                isSelected: selectedScreen == ScreensEnum.dashboard),
            button(
                text: 'Store',
                icon: Icons.storefront_outlined,
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StoreScreen())),
                isSelected: selectedScreen == ScreensEnum.store),
            const SizedBox(height: 24),
            menuButton(
                icon: Icons.backup_table_outlined,
                text: 'Products',
                menuItems: [
                  menuOptionButton(
                    context,
                      icon: Icons.category_outlined,
                      screenLocation:
                          const ProductsListingScreen(heading: 'All Products'),
                      text: 'All Products',),
                  menuOptionButton(context,
                      icon: Icons.add_circle_outline,
                      screenLocation: const AddProductScreen(),
                      text: 'Add New Products'),
                  menuOptionButton(context,
                      icon: Icons.add_circle_outline,
                      screenLocation: const AddAttributeAndOption(),
                      text: 'Add Attribute & option')
                ],
                isSelected: selectedScreen == ScreensEnum.productListing ||
                    selectedScreen == ScreensEnum.product ||
                    selectedScreen == ScreensEnum.productEdit),
            const SizedBox(height: 24),
            menuButton(
                icon: Icons.checklist_outlined,
                text: 'Orders',
                menuItems: [
                  menuOptionButton(context,
                      icon: Icons.shopping_cart_checkout_outlined,
                      screenLocation: const OrdersListingScreen(
                          heading: 'Active Orders', isRefundScreen: false),
                      text: 'Active Orders'),
                  menuOptionButton(context,
                      icon: Icons.shopping_cart,
                      screenLocation: const OrdersListingScreen(
                          heading: 'Total Orders', isRefundScreen: false),
                      text: 'Total Orders'),
                  menuOptionButton(context,
                      icon: Icons.reply_all_rounded,
                      screenLocation: const OrdersListingScreen(
                          heading: 'Refunds', isRefundScreen: true),
                      text: 'Refunds')
                ],
                isSelected: selectedScreen == ScreensEnum.ordersListing),
            button(
                text: 'Reviews',
                icon: Icons.reviews_outlined,
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReviewsScreen())),
                isSelected: selectedScreen == ScreensEnum.reviews),
            button(
                text: 'Logout',
                icon: Icons.power_settings_new,
                onTap: () {
                  user.removeUser();
                  /*Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));*/
                })
          ]))));
  }

  PopupMenuItem<dynamic> menuOptionButton(BuildContext context,
      {required String text,
      required IconData icon,
      required Widget screenLocation}) {
    return PopupMenuItem(
        child: GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => screenLocation)),
            child: Row(children: [
              Icon(icon),
              const SizedBox(width: 12),
              Text(text)
            ])));
  }

  Widget menuButton({
    required String text,
    required IconData icon,
    bool isSelected = false,
    required List<PopupMenuEntry> menuItems,
  }) =>
      PopupMenuButton(
          padding: const EdgeInsets.only(top: 28),
          offset: const Offset(58, 24),
          icon: Column(children: [
            Icon(icon,
                size: 28, color: isSelected ? white : white.withOpacity(0.6)),
            const SizedBox(height: 12),
            Text(text,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected ? white : white.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                    fontSize: 12))
          ]),
          elevation: 32,
          iconSize: 58,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16))),
          itemBuilder: (context) => menuItems);

  Widget button({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    bool isSelected = false,
  }) =>
      Column(children: [
        const SizedBox(height: 40),
        IconButton(
            onPressed: onTap,
            icon: Icon(icon),
            color: isSelected ? white : white.withOpacity(0.6),
            iconSize: 28),
        Text(text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: isSelected ? white : white.withOpacity(0.6),
                fontWeight: FontWeight.w500,
                fontSize: 12))
      ]);
}
