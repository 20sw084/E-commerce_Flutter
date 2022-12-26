import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ReviewCard extends StatelessWidget {
  final bool isDeletable;
  const ReviewCard({Key? key, this.isDeletable = false}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(children: [
        Row(children: [
          CircleAvatar(backgroundImage: AssetImage('$imagePath/sample_user_image.png'), radius: 32),
          const SizedBox(width: 16),
          const Text('Lauralee Quintero', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          const Spacer(),
          isDeletable
              ? Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(25)),
                  child: Icon(Icons.delete_outlined, color: white))
              : const SizedBox.shrink(),
          const SizedBox(width: 16),
          Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), border: Border.all(color: red, width: 1.3)),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Row(children: [
                Icon(Icons.star_rounded, color: red, size: 18),
                const SizedBox(width: 4),
                Text('5', style: TextStyle(color: red, fontWeight: FontWeight.w600)),
              ]))
        ]),
        const SizedBox(height: 16),
        Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text. It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
            style: TextStyle(color: Colors.grey.shade600)),
        const SizedBox(height: 12),
        Row(children: [
          Icon(CupertinoIcons.heart, color: black),
          const SizedBox(width: 8),
          const Text('74', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(width: 32),
          Text('1 week ago', style: TextStyle(color: Colors.grey.shade600))
        ]),
        const SizedBox(height: 48)
      ]);
}
