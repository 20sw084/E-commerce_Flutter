import 'package:flutter/material.dart';

import '../utils/constants.dart';

class HorizontalProductCard extends StatefulWidget {
  final bool isRefundScreen;
  const HorizontalProductCard({Key? key, required this.isRefundScreen}) : super(key: key);
  @override
  State<HorizontalProductCard> createState() => _HorizontalProductCardState();
}

class _HorizontalProductCardState extends State<HorizontalProductCard> {
  @override
  Widget build(BuildContext context) => Column(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 3,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('$imagePath/sample_product_image.jpg', width: 80, height: 120, fit: BoxFit.cover)),
                const SizedBox(width: 16),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('T-Shirt', maxLines: 1, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26)),
                  const SizedBox(height: 12),
                  Row(children: [
                    Text('Color: ', maxLines: 1, style: TextStyle(color: Colors.grey.shade600, fontSize: 18)),
                    const Text('Red', maxLines: 1, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                  ]),
                  Row(children: [
                    Text('Size: ', maxLines: 1, style: TextStyle(color: Colors.grey.shade600, fontSize: 18)),
                    const Text('XS', maxLines: 1, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
                  ])
                ])
              ])),
          Expanded(flex: 1, child: Text('\$ 347.0', maxLines: 1, style: TextStyle(color: red, fontSize: 22, fontWeight: FontWeight.w600))),
          Expanded(flex: 1, child: Text('40', maxLines: 1, style: TextStyle(color: Colors.grey.shade700, fontSize: 22, fontWeight: FontWeight.w500))),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          const Spacer(flex: 2),
          Expanded(
              flex: 3,
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: Border.all(color: red, width: 2), color: red, borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                  child: Text(widget.isRefundScreen ? 'Refund' : 'Available',
                      style: TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.w500)))),
          const SizedBox(width: 20),
          Expanded(
              flex: 3,
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: Border.all(color: red, width: 2), borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
                  child: Text(widget.isRefundScreen ? 'Cancel' : 'Out of Stock',
                      style: TextStyle(color: red, fontSize: 16, fontWeight: FontWeight.w500)))),
          const Spacer(flex: 2)
        ]),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 56),
      ]);
}
