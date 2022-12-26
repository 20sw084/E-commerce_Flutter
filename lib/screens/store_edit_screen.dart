import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickvilla/screens/store_screen.dart';
import 'package:quickvilla/services/create_category.dart';
import 'package:quickvilla/services/delete_category.dart';
import 'package:quickvilla/services/get_categories.dart';
import 'package:quickvilla/services/update_category.dart';
import 'package:quickvilla/services/update_store.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;
import 'package:quickvilla/widgets/primary_button.dart';
import '../utils/constants.dart';
import '../widgets/navigation_bar_vertical.dart';
import '../widgets/text_input_decoration.dart';
import 'package:geocode/geocode.dart';

class StoreEditScreen extends StatefulWidget {
  const StoreEditScreen({Key? key}) : super(key: key);

  @override
  State<StoreEditScreen> createState() => _StoreEditScreenState();
}

class _StoreEditScreenState extends State<StoreEditScreen> {
  String selectedCategory = '';
  String name = "";
  String description = "";
  String url = "";
  String address = "";
  int latitude = 0;
  int longitude = 0;
  String logo = "";
  String cover = "";
  String newCategoryName = "";
  String editCategoryName = "";
  late Future<dynamic> dataFuture;
  bool isLoading = false;
  final _categoryFormKey = GlobalKey<FormState>();
  File? _profileImg;
  File? _coverImg;
  final picker = ImagePicker();
  final categoryNameTextController = TextEditingController();

  void getCoordinates(address) async {
    GeoCode geoCode = GeoCode(apiKey: "96231433338094550100x34384");

    try {
      Coordinates coordinates =
          await geoCode.forwardGeocoding(address: "$address");

      print("Latitude: ${coordinates.latitude}");
      print("Longitude: ${coordinates.longitude}");
    } catch (e) {
      print(e);
    }
  }

  openGallery() async {
    dynamic image;
    dynamic pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 480,
      maxWidth: 640,
    );
    if (pickedFile != null) {
      image = File(pickedFile!.path);
      return image;
    } else {
      return null;
    }
  }

  // TODO update below list with categories from the api
  List<dynamic> categories = [];

  getCategories() async {
    await getCategoriesFromApi(token: globals.token).then((value) {
      setState(() {
        categories = value;
        selectedCategory = categories[0]["id"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataFuture = getCategoriesFromApi(token: globals.token);
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: SafeArea(
          child: Scaffold(
              body:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const NavigationBarVertical(selectedScreen: ScreensEnum.store),
        Expanded(
            flex: 5,
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(children: [
                      const SizedBox(height: 24),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.arrow_back),
                                iconSize: 32),
                            const SizedBox(width: 32),
                            const Text('Edit Store Information',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w500)),
                          ]),
                      const SizedBox(height: 40),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                                child: Text('Store Name',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: TextField(
                              decoration:
                                  textInputDecoration(label: 'Store Name'),
                              onChanged: (val) => name = val,
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
                                      borderRadius: BorderRadius.circular(10),
                                      isExpanded: true,
                                      underline: const SizedBox.shrink(),
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                      items: categories
                                          .map((val) =>
                                              DropdownMenuItem<String>(
                                                  value: val["id"].toString(),
                                                  child:
                                                      Text(val["name"] ?? "")))
                                          .toList(),
                                    )))
                          ]),
                      const SizedBox(height: 40),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                                child: Text('Store Profile Image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18))),
                            SizedBox(width: 18),
                            Expanded(
                                child: Text('Cover Image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18))),
                          ]),
                      const SizedBox(height: 16),
                      Row(
                          //mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TODO apply upload picture functionality
                            Expanded(
                                child: GestureDetector(
                                    onTap: () async {
                                      _profileImg = await openGallery();
                                      setState(() {});
                                    },
                                    behavior: HitTestBehavior.opaque,
                                    child: uploadImageButton())),
                            //const SizedBox(width: 18),
                            // TODO apply upload picture functionality
                            Expanded(
                              child: GestureDetector(
                                  onTap: () async {
                                    _coverImg = await openGallery();
                                    setState(() {});
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: uploadImageButton()),
                            )
                          ]),
                      const SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Row(children: [
                              Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade200,
                                          width: 4)),
                                  child: Stack(children: [
                                    Image(
                                      image: _profileImg == null
                                          ? const NetworkImage(
                                              "https://i.pinimg.com/originals/f6/d0/af/f6d0af482a5a1116dbbd2fd3ff95e58c.jpg")
                                          : FileImage(_profileImg!)
                                              as ImageProvider,
                                    ),
                                    //Image.file(_profileImg, fit: BoxFit.cover),
                                    Positioned(
                                        top: 6,
                                        right: 6,
                                        child: CircleAvatar(
                                            backgroundColor: red,
                                            radius: 12,
                                            child: Icon(Icons.close,
                                                size: 20, color: white)))
                                  ]))
                            ])),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.shade200,
                                            width: 4)),
                                    child: Stack(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Image(
                                          image: _coverImg == null
                                              ? const NetworkImage(
                                                  "https://i.pinimg.com/originals/f6/d0/af/f6d0af482a5a1116dbbd2fd3ff95e58c.jpg")
                                              : FileImage(_coverImg!)
                                                  as ImageProvider,
                                        ),

                                        /*Image.file(_coverImg,
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover)*/
                                      ),
                                      Positioned(
                                          top: 6,
                                          right: 6,
                                          child: CircleAvatar(
                                              backgroundColor: red,
                                              radius: 12,
                                              child: Icon(Icons.close,
                                                  size: 20, color: white)))
                                    ])))
                          ]),
                      const SizedBox(height: 40),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18))),
                      const SizedBox(height: 16),
                      TextField(
                          onChanged: (val) => description = val,
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
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Color(0xff9E9E9E)),
                                  borderRadius: BorderRadius.circular(12)),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              hintText: 'Store description...')),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Category',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18))),
                      const SizedBox(height: 16),
                      Form(
                        key: _categoryFormKey,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  onChanged: (val) => newCategoryName = val,
                                  validator: (val) => val!.isEmpty
                                      ? "Please enter a name first"
                                      : null,
                                  decoration: InputDecoration(
                                      fillColor: const Color(0xffF0F0F0),
                                      focusColor: const Color(0xff9E9E9E),
                                      filled: true,
                                      hintStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff808080)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xffF0F0F0)),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2,
                                              color: Color(0xff9E9E9E)),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 24),
                                      hintText: 'Store category...')),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  // TODO set validation
                                  if (_categoryFormKey.currentState!
                                      .validate()) {
                                    isLoading = true;
                                    context.loaderOverlay.show();
                                    dynamic response = await createCategory(
                                            token: globals.token,
                                            name: newCategoryName)
                                        .whenComplete(() => isLoading = false);
                                    if (!isLoading)
                                      context.loaderOverlay.hide();
                                    if (response != null) {
                                      await getCategories();
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
                                      setState(() {
                                        dataFuture = getCategoriesFromApi(
                                            token: globals.token);
                                      });
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
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

                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                          contentType: ContentType.success,
                                        ),
                                      );
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(0)),
                                  elevation: MaterialStateProperty.all(1.0),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffA00000),
                                  ),
                                  shadowColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.onSurface),
                                ),
                                child: const Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xffA00000),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Row(
                            children: const [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Id',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              // SizedBox(width: 50.0,),
                              Expanded(
                                flex: 6,
                                child: Text(
                                  'Category Name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: FutureBuilder(
                              future: dataFuture,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  dynamic data = snapshot.data;
                                  return ListView.builder(
                                      itemCount: data!.length,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                data[index]["id"].toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                data[index]["name"],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: SingleChildScrollView(
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        openDialog(
                                                            categoryId:
                                                                data[index]
                                                                    ["id"]);
                                                      },
                                                      child: const Icon(
                                                        Icons.edit,
                                                        color:
                                                            Color(0xffA00000),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        isLoading = true;
                                                        context.loaderOverlay
                                                            .show();
                                                        dynamic
                                                            response =
                                                            await deleteCategory(
                                                                    token: globals
                                                                        .token,
                                                                    id: data[index]
                                                                            [
                                                                            "id"]
                                                                        .toString())
                                                                .whenComplete(() =>
                                                                    isLoading =
                                                                        false);
                                                        if (isLoading ==
                                                            false) {
                                                          context.loaderOverlay
                                                              .hide();
                                                        }
                                                        if (response != null) {
                                                          await getCategories();
                                                          final snackBar =
                                                              SnackBar(
                                                            /// need to set following properties for best effect of awesome_snackbar_content
                                                            elevation: 0,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        3000),
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            content:
                                                                AwesomeSnackbarContent(
                                                              title: 'Success!',
                                                              message: response,

                                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                              contentType:
                                                                  ContentType
                                                                      .success,
                                                            ),
                                                          );
                                                          setState(() {
                                                            dataFuture =
                                                                getCategoriesFromApi(
                                                                    token: globals
                                                                        .token);
                                                          });
                                                          if (!mounted) return;
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..hideCurrentSnackBar()
                                                            ..showSnackBar(
                                                                snackBar);
                                                        } else {
                                                          final snackBar =
                                                              SnackBar(
                                                            /// need to set following properties for best effect of awesome_snackbar_content
                                                            elevation: 0,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        3000),
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            content:
                                                                AwesomeSnackbarContent(
                                                              title: 'Error!',
                                                              message:
                                                                  "Something went wrong",
                                                              contentType:
                                                                  ContentType
                                                                      .failure,
                                                            ),
                                                          );
                                                          if (!mounted) return;
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..hideCurrentSnackBar()
                                                            ..showSnackBar(
                                                                snackBar);
                                                        }
                                                        //setState(() {});
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color:
                                                            Color(0xffA00000),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        ),
                      ),
                      const SizedBox(height: 48),
                      PrimaryButton(
                          text: 'Save',
                          onTap: () async {
                            isLoading = true;
                            context.loaderOverlay.show();
                            dynamic response = await updateStore(
                                token: globals.token,
                                name: name,
                                description: description,
                                url: url,
                                address: address,
                                latitude: 20,
                                longitude: 20,
                                categories: categories,
                                logo: _profileImg!,
                                cover: _coverImg!)
                            .whenComplete(() => isLoading = false);
                            if(!isLoading) {
                              context.loaderOverlay.hide();
                            }
                            if (response != null) {
                              await getCategories();
                              setState(() {
                                dataFuture = getCategoriesFromApi(token: globals.token);
                              });
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                duration: const Duration(milliseconds: 3000),
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const StoreScreen()));
                            }
                            else {
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                duration: const Duration(milliseconds: 3000),
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
                            //Navigator.pop(context);
                          })
                    ])))),
      ]))),
    );
  }

  Container uploadImageButton() => Container(
      width: double.infinity,
      height: 48,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Select from device',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Color(0xff808080))),
            Icon(Icons.add_photo_alternate_outlined,
                size: 22, color: Color(0xffaaaaaa))
          ]));

  Future<String?> openDialog({required int categoryId}) => showDialog<String>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Edit Category'),
          content: TextField(
            onChanged: (val) => editCategoryName = val,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter Name Here'),
            controller: categoryNameTextController,
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                isLoading = true;

                context.loaderOverlay.show();
                dynamic response = await updateCategory(
                        token: globals.token,
                        name: editCategoryName,
                        id: categoryId.toString())
                    .whenComplete(() => isLoading = false);
                if (isLoading == false) {
                  context.loaderOverlay.hide();
                }
                if (response != null) {
                  await getCategories();
                  final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    duration: const Duration(milliseconds: 3000),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Success!',
                      message: response,

                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                      contentType: ContentType.success,
                    ),
                  );
                  setState(() {
                    dataFuture = getCategoriesFromApi(token: globals.token);
                  });
                  if (!mounted) return;
                  Navigator.pop(context);
                  if (!mounted) return;
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
                else {
                  final snackBar = SnackBar(
                    /// need to set following properties for best effect of awesome_snackbar_content
                    elevation: 0,
                    duration: const Duration(milliseconds: 3000),
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
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
}
