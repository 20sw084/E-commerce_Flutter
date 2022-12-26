import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickvilla/models/user_model.dart';
import 'package:quickvilla/utils/constants.dart';
import 'package:quickvilla/widgets/analytics_chart.dart';
import 'package:quickvilla/widgets/navigation_bar_vertical.dart';

import '../widgets/stars_row.dart';
import '../widgets/statistics_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SafeArea(
          child: Scaffold(
              body: Row(children: [
        const NavigationBarVertical(selectedScreen: ScreensEnum.dashboard),
        Expanded(
            flex: 5,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(children: [
                  const SizedBox(height: 60),
                  Row(children: [
                    Container(
                        width: 114,
                        height: 114,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: white,
                            image: DecorationImage(
                                image: NetworkImage(
                                    user.mystore["logo"]),
                                fit: BoxFit.cover),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 4))),
                    const SizedBox(width: 24),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(user.mystore["name"],
                              maxLines: 1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 32)),
                          Row(children: [
                            Icon(Icons.location_on,
                                color: Colors.grey.shade500, size: 18),
                            const SizedBox(width: 4),
                            Text(user.mystore["address"] ?? "N/A",
                                maxLines: 1,
                                style: TextStyle(color: Colors.grey.shade600)),
                          ]),
                          const SizedBox(height: 8),
                          const StarsRow(highlighted: 4, total: 5),
                        ])
                  ]),
                  const SizedBox(height: 48),
                  const AnalyticsChart(),
                  const SizedBox(height: 50),
                  Row(children: [
                    StatisticsCard(
                        text1: '162.9k',
                        text2: 'Last 7 days Sells',
                        text3: '10% Increase from Last Week',
                        color: Colors.cyanAccent.shade200.withOpacity(0.2)),
                    const SizedBox(width: 24),
                    StatisticsCard(
                        text1: '2390',
                        text2: 'Last 7 days Refunds',
                        text3: '12% Increse from Last Week',
                        color: Colors.deepOrange.shade100.withOpacity(0.5)),
                    const SizedBox(width: 24),
                    StatisticsCard(
                        text1: '59%',
                        text2: 'Last 7 days Profit',
                        text3: '3% Decrease from Last Week',
                        color: Colors.purpleAccent.shade100.withOpacity(0.3)),
                  ]),
                ])))
      ])));
  }
}
