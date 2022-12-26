import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/navigation_bar_vertical.dart';
import '../widgets/review_card.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({Key? key}) : super(key: key);
  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
              body: Row(children: [
        const NavigationBarVertical(selectedScreen: ScreensEnum.reviews),
        Expanded(
            flex: 5,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const SizedBox(height: 24),
                  Row(children: [
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back), iconSize: 32),
                    const SizedBox(width: 32),
                    const Text('Reviews', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500))
                  ]),
                  const SizedBox(height: 24),
                  Expanded(
                      child: ListView.builder(itemCount: 12, shrinkWrap: true, itemBuilder: (context, index) => const ReviewCard(isDeletable: true)))
                ])))
      ])));
}
