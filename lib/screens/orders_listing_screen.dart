import 'package:flutter/material.dart';
import 'package:quickvilla/services/active_orders.dart';
import '../utils/constants.dart';
import '../widgets/horizontal_product_card.dart';
import '../widgets/navigation_bar_vertical.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;

class OrdersListingScreen extends StatefulWidget {
  final String heading;
  final bool isRefundScreen;
  const OrdersListingScreen(
      {Key? key, required this.heading, required this.isRefundScreen})
      : super(key: key);
  @override
  State<OrdersListingScreen> createState() => _OrdersListingScreenState();
}

class _OrdersListingScreenState extends State<OrdersListingScreen> {
  late Future<dynamic> dataFuture;

  @override
  void initState() {
    super.initState();

    dataFuture = activeOrders(token: globals.token);
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
              body: Row(children: [
        const NavigationBarVertical(selectedScreen: ScreensEnum.reviews),
        Expanded(
            flex: 5,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Row(children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back),
                            iconSize: 32),
                        const SizedBox(width: 32),
                        Text(widget.heading,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w500))
                      ]),
                      const SizedBox(height: 40),
                      Row(children: const [
                        Expanded(
                            flex: 3,
                            child: Text('Product',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))),
                        Expanded(
                            flex: 1,
                            child: Text('Price',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))),
                        Expanded(
                            flex: 1,
                            child: Text('Quantity',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))),
                      ]),
                      const SizedBox(height: 16),
                      Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.grey.shade300),
                      const SizedBox(height: 24),
                      Expanded(
                          child: FutureBuilder(
                              future: dataFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.none ||
                                    snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasData) {
                                  dynamic data = snapshot.data;
                                  return ListView.builder(
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) =>
                                          // Text(data[index]["product"]["name"])
                                          HorizontalProductCard(
                                              isRefundScreen:
                                                  widget.isRefundScreen));
                                } else {
                                  return const Center(
                                      child: Text("There are no orders yet"));
                                }
                              }))
                    ])))
      ])));
}
