import 'dart:io';
import 'dart:developer';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:quickvilla/models/variations_model.dart';
import 'package:quickvilla/screens/home_screen.dart';
import 'package:quickvilla/screens/products_listing_screen.dart';
import 'package:quickvilla/services/fetch_all_variations.dart';
import 'package:quickvilla/services/get_categories.dart';
import 'package:quickvilla/services/update_simple_product.dart';
import 'package:quickvilla/widgets/primary_button.dart';
import '../utils/constants.dart';
import '../widgets/navigation_bar_vertical.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;
import '../widgets/text_input_decoration.dart';

enum ProductType { simple, variation }

class EditProductScreen extends StatefulWidget {
  final String name;
  final String description;
  final String shortDescription;
  final String productType;
  final String salePrice;
  final String price;
  final String id;

  const EditProductScreen(
      {Key? key,
      required this.name,
      required this.id,
      required this.description,
      required this.shortDescription,
      required this.productType,
      required this.salePrice,
      required this.price})
      : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  bool isFeaturedSelected = false;
  bool isTaxFreeSelected = false;
  String selectedCategory = '';
  ProductType? _productType = ProductType.simple;
  bool isLoading = false;
  File? productImg;
  List? _attributeIdList;
  List? _variationsList;
  String variantPrice = "";
  String variantSalePrice = "";
  String price = "";
  String salePrice = "";
  File convertToFile(XFile image) => File(image.path);
  final productNameTextController = TextEditingController();
  final productPriceTextController = TextEditingController();
  final salePriceTextController = TextEditingController();
  final productDescriptionTextController = TextEditingController();
  final productShortDescriptionTextController = TextEditingController();
  final categoryNameTextController = TextEditingController();

  // Variant price & saleprice
  final variantPriceTextController = TextEditingController();
  final variantSalePriceTextController = TextEditingController();
  List<dynamic> categories = [];
  getDropdownData() async {
    await getCategoriesFromApi(token: globals.token).then((value) {
      setState(() {
        categories = value;
        selectedCategory = categories[0]["id"].toString();
      });
    });
  }
  Future<dynamic>? futureAttrList;
  Future<dynamic>? futureVariationsList;
  dynamic attributeListFromApi;

  final List<File> _image = [];
  final picker = ImagePicker();

  openGallery() async {
    dynamic pickedFile = await picker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 480,
    maxWidth: 640,
        );

    if (!mounted) return;
    if (pickedFile != null) {
      setState(() {
        _image.add(File(pickedFile!.path));
      });
      return pickedFile;
    } else {
      return null;
    }
  }
  @override
  void initState() {
    super.initState();
    getDropdownData();
    productNameTextController.text = widget.name;
    productPriceTextController.text = widget.price;
    salePriceTextController.text = widget.salePrice;
    productDescriptionTextController.text = widget.description;
    productShortDescriptionTextController.text = widget.shortDescription;
  }

  @override
  void dispose() {
    super.dispose();
    productNameTextController.clear();
    productPriceTextController.clear();
    salePriceTextController.clear();
    productDescriptionTextController.clear();
    productShortDescriptionTextController.clear();
    categoryNameTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final variationsProvider = Provider.of<Variations>(context);
    return LoaderOverlay(
      child: SafeArea(
          child: Scaffold(
              body: Row(children: [
        const NavigationBarVertical(selectedScreen: ScreensEnum.product),
        Expanded(
            flex: 5,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.arrow_back),
                                      iconSize: 32),
                                  const SizedBox(width: 32),
                                  const Text('Product Information',
                                      style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w500)),
                                  const Spacer(),
                                  SizedBox(
                                      width: 120,
                                      height: 40,
                                      child: PrimaryButton(
                                          text: 'Save',
                                          onTap: () => Navigator.pop(context)))
                                ]),
                            const SizedBox(height: 40),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                      child: Text("Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18))),
                                  SizedBox(width: 18),
                                  Expanded(
                                      child: Text('Category',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18))),
                                ]),
                            const SizedBox(height: 16),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: TextField(
                                    decoration: textInputDecoration(
                                        label: 'Store Name'),
                                    controller: productNameTextController,
                                  )),
                                  const SizedBox(width: 18),
                                  Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              right: 12, left: 16),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffF0F0F0),
                                              borderRadius:
                                              BorderRadius.circular(12)),
                                          height: 50,
                                          alignment: Alignment.center,
                                          child: DropdownButton<String>(
                                            value: selectedCategory,
                                            onChanged: (value) => setState(() =>
                                            selectedCategory = value.toString()),
                                            iconEnabledColor: red,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            isExpanded: true,
                                            underline: const SizedBox.shrink(),
                                            style: TextStyle(
                                                color: Colors.grey.shade700),
                                            items: categories
                                                .map((val) => DropdownMenuItem<String>(
                                                value: val["id"].toString(),
                                                child: Text(val["name"]??"")))
                                                .toList(),
                                          )
                                      ))
                                ]),
                            const SizedBox(height: 40),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Expanded(
                                    child: Text('Price',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18)),
                                  ),
                                  SizedBox(width: 18),
                                  Expanded(
                                      child: Text('Sale Price',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18))),
                                ]),
                            const SizedBox(height: 16),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: TextField(
                                    decoration: textInputDecoration(
                                        label: 'Product Price'),
                                    controller: productPriceTextController,
                                        onChanged: (val) {
                                          price = val;
                                        },
                                  )),
                                  const SizedBox(width: 18),
                                  Expanded(
                                      child: TextField(
                                    decoration: textInputDecoration(
                                        label: 'Sale Price'),
                                        onChanged: (val) {
                                          salePrice = val;
                                        },
                                    controller: salePriceTextController,
                                  )),
                                ]),
                            const SizedBox(height: 32),
                            Text('Short Description',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 16),
                            TextField(
                                controller: productShortDescriptionTextController,
                                minLines: 1,
                                maxLines: 2,
                                decoration: InputDecoration(
                                    fillColor: const Color(0xffF0F0F0),
                                    focusColor: const Color(0xff9E9E9E),
                                    filled: true,
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff808080)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Color(0xffF0F0F0)),
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Color(0xff9E9E9E)),
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    hintText: 'Short description...')),
                            const SizedBox(height: 32),
                            Text('Description',
                                style: TextStyle(
                                    color: black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 16),
                            TextField(
                                controller: productDescriptionTextController,
                                // expands: true,
                                minLines: 1,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    fillColor: const Color(0xffF0F0F0),
                                    focusColor: const Color(0xff9E9E9E),
                                    filled: true,
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff808080)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Color(0xffF0F0F0)),
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Color(0xff9E9E9E)),
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    hintText: 'Short description...')),
                            const SizedBox(height: 40),
                            const Text('Product Image',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18)),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () async {
                                final status =
                                    await Permission.storage.request();
                                if (status == PermissionStatus.granted) {
                                  dynamic image = await openGallery();
                                  setState(() {});
                                  productImg = convertToFile(image!);
                                } else if (status == PermissionStatus.denied) {
                                  CupertinoAlertDialog(
                                    title: const Text('Camera Permission'),
                                    content: const Text(
                                        'This app needs Storage access'),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: const Text('Deny'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                      CupertinoDialogAction(
                                        child: const Text('Settings'),
                                        onPressed: () => openAppSettings(),
                                      ),
                                    ],
                                  );
                                } else if (status ==
                                    PermissionStatus.permanentlyDenied) {
                                  await openAppSettings();
                                }
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF0F0F0),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text('Select image from device',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15,
                                                color: Color(0xff808080))),
                                        Icon(Icons.add_photo_alternate_outlined,
                                            size: 22, color: Color(0xffaaaaaa))
                                      ])),
                            ),
                            const SizedBox(height: 16),

                            SizedBox(
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _image.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              height: 100,
                                              width: 100,
                                              margin: const EdgeInsets.only(
                                                  right: 16),
                                              decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade200,
                                                      width: 4)),
                                              child: Stack(children: [
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: Image.file(
                                                        _image[index],
                                                        height: 120,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover)),
                                                Positioned(
                                                    top: 6,
                                                    right: 6,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _image
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: CircleAvatar(
                                                          backgroundColor: red,
                                                          radius: 12,
                                                          child: Icon(
                                                              Icons.close,
                                                              size: 20,
                                                              color: white)),
                                                    ))
                                              ])));
                                    })),
                            const SizedBox(height: 40),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Simple",
                                    ),
                                    Radio<ProductType>(
                                      value: ProductType.simple,
                                      groupValue: _productType,
                                      onChanged: (ProductType? value) {
                                        setState(() {
                                          _productType = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Variable",
                                    ),
                                    Radio<ProductType>(
                                      value: ProductType.variation,
                                      groupValue: _productType,
                                      onChanged: (ProductType? value) {
                                        setState(() {
                                          _productType = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                            Visibility(
                              visible: _productType == ProductType.variation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product attributes",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10.0, top: 20.0),
                                    child: Container(
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 10.0),
                                        child: FutureBuilder(
                                            future: futureAttrList,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting ||
                                                  snapshot.connectionState ==
                                                      ConnectionState.none) {
                                                return const Center(
                                                    child:
                                                    CircularProgressIndicator());
                                              }
                                              if (snapshot.hasData) {
                                                attributeListFromApi =
                                                    snapshot.data;
                                                return ListView.builder(
                                                    scrollDirection:
                                                    Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                    attributeListFromApi
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                        child: Container(
                                                          width: 180,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Colors
                                                                .grey.shade400,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10.0),
                                                          ),
                                                          // TODO fetch all attributes
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    8.0,
                                                                    left:
                                                                    8.0),
                                                                child:
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(() {
                                                                      attributeListFromApi
                                                                          .removeAt(
                                                                          index);
                                                                    });
                                                                  },
                                                                  child: const Icon(
                                                                      Icons
                                                                          .highlight_remove),
                                                                ),
                                                              ),
                                                              Text(
                                                                attributeListFromApi[
                                                                index]
                                                                ["name"],
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                    fontSize: 15,
                                                                    color: Color(
                                                                        0xff808080)),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              } else {
                                                return const Center(
                                                    child: Text(
                                                        "There are no attributes yet"));
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, left: 20.0, bottom: 20.0),
                                    child: PrimaryButton(
                                      text: "Select",
                                      onTap: () async {
                                        _attributeIdList = attributeListFromApi
                                            .map((value) => value["id"])
                                            .toList();
                                        // get variationsList for populating model
                                        _variationsList =
                                        await fetchAllVariations(
                                            token: globals.token,
                                            id: _attributeIdList!);
                                        for (var element in variationsProvider
                                            .variationsList) {
                                          element["price"] = price;
                                          element["sale_price"] = salePrice;
                                          element["name"] = productNameTextController.text;
                                        }
                                        log("After setting prices for each element: ${variationsProvider.variationsList.toString()}");
                                        setState(() {
                                          futureVariationsList =
                                              fetchAllVariations(
                                                  token: globals.token,
                                                  id: _attributeIdList!);
                                        });
                                        variationsProvider
                                            .getVariantsList(_variationsList);
                                        // TODO
                                        /*call fetch all Variations API, based on Attribute Ids,
                                     selected above, by default all available attributes will be
                                     loaded, then user will have the choice to remove some values*/
                                      },
                                    ),
                                  ),
                                  const SizedBox(),
                                  FutureBuilder(
                                      future: futureVariationsList,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: CircularProgressIndicator());
                                        }
                                        if (snapshot.hasData) {
                                          dynamic data = snapshot.data;
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: data.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    /*VariationWidget(
                                                    color: data[index]["Color"],
                                                    size: data[index]["Size"],
                                                    custom: data[index]["Custom"],
                                                    price: price,
                                                    salePrice: salePrice,
                                                  ),*/
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0),
                                                      child: Text("Variation",
                                                          style: TextStyle(
                                                              color: black,
                                                              fontSize: 22,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0,
                                                          top: 20.0),
                                                      child: Container(
                                                        height: 70.0,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey.shade300,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(15.0),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 20.0),
                                                              child: Text(
                                                                data[index]["Color"] != null ? data[index]["Color"]["name"] : "No color available",
                                                                style:
                                                                const TextStyle(
                                                                  fontSize: 15.0,
                                                                  color: Color(
                                                                      0xff808080),
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right:
                                                                  10.0),
                                                              child: Text("-"),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(
                                                                  left: 10.0),
                                                              child: Text(
                                                                data[index]["Size"] != null ? data[index]["Size"]["name"] : "No size available",

                                                                style: const TextStyle(
                                                                  fontSize: 15.0,
                                                                  color: Color(
                                                                      0xff808080),
                                                                ),
                                                              ),
                                                            ),
                                                            const Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  left: 10.0,
                                                                  right:
                                                                  10.0),
                                                              child: Text("-"),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets.only(
                                                                  left: 10.0),
                                                              child: Text(
                                                                data[index]["Size"] != null ? data[index]["Size"]["name"] : "No custom attribute Available",
                                                                style: const TextStyle(
                                                                  fontSize: 15.0,
                                                                  color: Color(
                                                                      0xff808080),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0,
                                                          top: 20.0),
                                                      child: Row(
                                                        children: [
                                                          Text("Price",
                                                              style: TextStyle(
                                                                  color: black,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                          const SizedBox(
                                                            width: 200,
                                                          ),
                                                          Text("Sale Price",
                                                              style: TextStyle(
                                                                  color: black,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0,
                                                          top: 20.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: TextField(
                                                                controller:
                                                                variantPriceTextController,
                                                                decoration:
                                                                textInputDecoration(
                                                                    label:
                                                                    'Price')
                                                                    .copyWith(
                                                                    hintText:
                                                                    "Enter Price"),
                                                                keyboardType:
                                                                TextInputType
                                                                    .number,
                                                                onChanged: (val) =>
                                                                variantPrice =
                                                                    val,
                                                              )),
                                                          const SizedBox(
                                                            width: 55,
                                                          ),
                                                          Expanded(
                                                              child: TextField(
                                                                controller:
                                                                variantSalePriceTextController,
                                                                decoration: textInputDecoration(
                                                                    label:
                                                                    'Sale Price')
                                                                    .copyWith(
                                                                    hintText:
                                                                    "Enter Sale Price"),
                                                                keyboardType:
                                                                TextInputType
                                                                    .number,
                                                                onChanged: (val) =>
                                                                variantSalePrice =
                                                                    val,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 30.0,
                                                                left: 20,
                                                                bottom: 20.0),
                                                            child: PrimaryButton(
                                                              text: 'Delete',
                                                              onTap: () {
                                                                variationsProvider
                                                                    .removeFromVariations(
                                                                    index:
                                                                    index);
                                                                setState(() {
                                                                  data.removeAt(
                                                                      index);
                                                                });
                                                              },
                                                            )),
                                                        Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 30.0,
                                                                left: 20,
                                                                bottom: 20.0),
                                                            child: PrimaryButton(
                                                              text: 'Save',
                                                              onTap: () {
                                                                variationsProvider
                                                                    .variationsList[
                                                                index]
                                                                [
                                                                "price"] =
                                                                    variantPrice;
                                                                variationsProvider
                                                                    .variationsList[
                                                                index]
                                                                [
                                                                "sale_price"] =
                                                                    variantSalePrice;
                                                              },
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              });
                                        } else {
                                          return const SizedBox();
                                        }
                                      }),
                                ],
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                      value: isFeaturedSelected,
                                      onChanged: (value) => setState(
                                          () {
                                            isFeaturedSelected = value!;
                                          }),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                  const Text('Featured Product',
                                      style: TextStyle(fontSize: 16)),
                                  const SizedBox(width: 40),
                                  Checkbox(
                                      value: isTaxFreeSelected,
                                      onChanged: (value) => setState(
                                          () => isTaxFreeSelected = value!),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6))),
                                  const Text('Tax Free',
                                      style: TextStyle(fontSize: 16)),
                                ]),

                             const SizedBox(height: 40),
                            Align(
                                alignment: Alignment.center,
                                child: PrimaryButton(
                                    text: 'Save',
                                    onTap: () async {
                                     if(_productType == ProductType.simple) {
                                        isLoading = true;
                                        context.loaderOverlay.show();
                                        dynamic response =
                                            await updateSimpleProduct(
                                          product_id: widget.id,
                                          token: globals.token,
                                          name: productNameTextController.text,
                                          description:
                                              productDescriptionTextController
                                                  .text,
                                          shortDescription:
                                              productShortDescriptionTextController
                                                  .text,
                                          productType:
                                              _productType.toString(),
                                          price:
                                              productPriceTextController.text,
                                          salePrice:
                                              salePriceTextController.text,
                                          status: "published",
                                          // TODO published should be set as variable
                                          isStoreFeatured:
                                              isFeaturedSelected == true
                                                  ? "1"
                                                  : "0",
                                          image: productImg,
                                          category: selectedCategory,
                                        ).whenComplete(() => isLoading = false);
                                        if (!isLoading) {
                                          context.loaderOverlay.hide();
                                        }
                                        if (response != null) {
                                          log(response.toString());
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            /*duration: const Duration(
                                    milliseconds: 3000),*/
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'Success!',
                                              message: response,

                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                              contentType: ContentType.success,
                                            ),
                                          );
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProductsListingScreen(
                                                          heading:
                                                              "All Products")));
                                        } else {
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            /*duration: const Duration(
                                    milliseconds: 3000),*/
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'Error!',
                                              message: "Something went wrong",
                                              contentType: ContentType.failure,
                                            ),
                                          );
                                          if (!mounted) return;
                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);
                                        }
                                        () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen(),
                                              ),
                                            );
                                      }
                                     else {
                                       // TODO call updateVariableProduct
                                     }
                                    }
                                    )),
                            const SizedBox(height: 48),
                          ]))
                ])))
      ]))),
    );
  }
}
