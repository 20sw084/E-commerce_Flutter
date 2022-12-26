import 'package:flutter/material.dart';
import 'package:quickvilla/utils/constants.dart';
import 'package:quickvilla/widgets/text_input_decoration.dart';

class VariationWidget extends StatefulWidget {
  final Map<String, dynamic>? color;
  final Map<String, dynamic>? size;
  final Map<String, dynamic>? custom;
  final String price;
  final String salePrice;

  const VariationWidget(
      {required this.color,
        required this.size,
        required this.custom,
        required this.price,
        required this.salePrice,
        Key? key})
      : super(key: key);

  @override
  State<VariationWidget> createState() => _VariationWidgetState();
}

class _VariationWidgetState extends State<VariationWidget> {

  final priceTextEditingController = TextEditingController();
  final salePriceTextEditingController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    priceTextEditingController.text = widget.price;
    salePriceTextEditingController.text = widget.salePrice;
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text("Variation",
              style: TextStyle(
                  color: black, fontSize: 22, fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 20.0),
          child: Container(
            height: 70.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    widget.color != null
                        ? widget.color!["name"]
                        : "no color available",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Color(0xff808080),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text("-"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.size != null
                        ? widget.size!["name"]
                        : "no size available",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Color(0xff808080),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text("-"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.custom != null
                        ? widget.custom!["name"]
                        : "no custom attributes",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Color(0xff808080),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 20.0),
          child: Row(
            children: [
              Text("Price",
                  style: TextStyle(
                      color: black, fontSize: 22, fontWeight: FontWeight.w500)),
              const SizedBox(
                width: 200,
              ),
              Text("Sale Price",
                  style: TextStyle(
                      color: black, fontSize: 22, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 20.0),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                    controller: priceTextEditingController,
                    decoration:
                    textInputDecoration(label: 'Price').copyWith(hintText: "Enter Price"),
                    keyboardType: TextInputType.number,
                    //onChanged: (val) => salePrice = val,
                  )),
              const SizedBox(
                width: 55,
              ),
              Expanded(
                  child: TextField(
                    controller: salePriceTextEditingController,
                    decoration: textInputDecoration(label: 'Sale Price').copyWith(hintText: "Enter Sale Price"),
                    keyboardType: TextInputType.number,
                    //onChanged: (val) => salePrice = val,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
