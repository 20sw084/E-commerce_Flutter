// import 'package:flutter/material.dart';
// import 'package:quickvilla/widgets/variation_product.dart';
// class Variable extends StatefulWidget {
//   const Variable({Key? key}) : super(key: key);
//
//   @override
//   State<Variable> createState() => _VariableState();
// }
//
// class _VariableState extends State<Variable> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 20.0),
//               child: Text("Product attributes",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//             Padding(
//               padding:  EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
//               child: Container(
//                 height: 80.0,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Padding(
//                       padding:  EdgeInsets.only(left: 10.0),
//                       child: Container(
//                         height: 50.0,
//                         width: 180.0,
//                         decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Icon(Icons.highlight_remove),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Text("Iphone color",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18.0,
//                                 ),
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding:  EdgeInsets.only(left: 10.0),
//                       child: Container(
//                         height: 50.0,
//                         width: 180.0,
//                         decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Icon(Icons.highlight_remove),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Text("Iphone size",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18.0,
//                                 ),
//                               ),
//                             ),
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: Container(
//                         height: 50.0,
//                         width: 180.0,
//                         decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Icon(Icons.highlight_remove),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10.0),
//                               child: Text("Iphone model",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 18.0,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0, left: 20.0, bottom: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 50.0,
//                     width: 150.0,
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Select",
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(),
//             VariationWidget(),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
