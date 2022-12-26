import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickvilla/services/all_options.dart';
import 'package:quickvilla/services/create_attribute.dart';
import 'package:quickvilla/services/create_options.dart';
import 'package:quickvilla/services/delete_attribute.dart';
import 'package:quickvilla/services/delete_options.dart';
import 'package:quickvilla/services/get_attributes.dart';
import 'package:quickvilla/utils/constants.dart';
import 'package:quickvilla/utils/global_variables.dart' as globals;
import 'package:quickvilla/widgets/navigation_bar_vertical.dart';
import '../services/update_attribute.dart';
import '../services/update_options.dart';

class AddAttributeAndOption extends StatefulWidget {
  const AddAttributeAndOption({Key? key}) : super(key: key);

  @override
  State<AddAttributeAndOption> createState() => _AddAttributeAndOptionState();
}

const List<String> list = <String>[
  'Color',
];
String dropdownValue = list.first;

class _AddAttributeAndOptionState extends State<AddAttributeAndOption> {
  bool isLoading = false;

  // TODO use below keys in forms
  List<dynamic> attrDdList = [];
  dynamic hex;
  String attributeOptionName = "";
  String attrType = "";
  String attrName = "";
  String editAttrName = "";
  String editOptionName = "";


  void changeColor(Color color) {
    setState(() => pickerColors = color);
  }

  // create some values
  Color pickerColors = const Color(0xffff0000);
  Color currentColors = const Color(0xffA00000);

  /*final _attributeFormKey = GlobalKey<FormState>();
  final _attributeOptionsFormKey = GlobalKey<FormState>();*/
  String selectedAttributeId = '';
  Future<dynamic>? futureAttrList;
  Future<dynamic>? futureAttrOptionsList;
  List<String> items = ['custom', 'color', 'size'];
  String? selectedItem = 'custom';
  bool showColor = false;
  TextEditingController nameAttributeTextEditingController = TextEditingController();
  final attrNameTextController = TextEditingController();
  final colorHexTextController = TextEditingController();

  getDropdownData() async {
    await getAttributesFromApi(token: globals.token).then((val) {
      setState(() {
        attrDdList = val;
        selectedAttributeId = attrDdList[0]["id"].toString();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    // attrNameTextController.clear();
    // attrOptionsTextController.clear();
    colorHexTextController.clear();
  }

  @override
  void initState() {
    // log(globals.token);
    super.initState();
    getDropdownData();
    futureAttrList = getAttributesFromApi(token: globals.token);
    futureAttrOptionsList = getAllOptions(token: globals.token);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoaderOverlay(
        child: Scaffold(
          body: Row(
            children: [
              const NavigationBarVertical(selectedScreen: ScreensEnum.product),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 28.0,
                              ),
                            ),
                            title: const Text(
                              'Attribute & option',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset:
                                    const Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Add Attribute',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    openAddAttrDialog();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.0, vertical: 12.0),
                                      child: Text(
                                        'Add Attribute',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            'S.no',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          )),
                                      Expanded(
                                          flex: 6,
                                          child: Text(
                                            'Type',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: SingleChildScrollView(
                                    child: FutureBuilder(
                                        future: futureAttrList,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            dynamic data = snapshot.data;
                                            return SizedBox(
                                              height: 120,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: data.length,
                                                  itemBuilder: (context, index) {
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            (index + 1).toString(),
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
                                                          flex: 4,
                                                          child: Text(
                                                            data[index]["type"],
                                                            style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight.w600),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    openAttrEditDialog(
                                                                        attrId: data[
                                                                                    index]
                                                                                ["id"]
                                                                            .toString());
                                                                  },
                                                                  child: const Icon(
                                                                    Icons.edit,
                                                                    color: Color(
                                                                        0xffA00000),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () async {
                                                                    isLoading = true;
                                                                    context
                                                                        .loaderOverlay
                                                                        .show();
                                                                    dynamic response =
                                                                        await deleteAttribute(
                                                                      token: globals
                                                                          .token,
                                                                      id: data[index]
                                                                              ["id"]
                                                                          .toString(),
                                                                    ).whenComplete(() =>
                                                                            isLoading =
                                                                                false);
                                                                    if (isLoading ==
                                                                        false) {
                                                                      context
                                                                          .loaderOverlay
                                                                          .hide();
                                                                    }
                                                                    if (response !=
                                                                        null) {
                                                                      final snackBar =
                                                                          SnackBar(
                                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                                        elevation: 0,
                                                                        duration: const Duration(
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
                                                                          title:
                                                                              'Success!',
                                                                          message:
                                                                              response,

                                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                          contentType:
                                                                              ContentType
                                                                                  .success,
                                                                        ),
                                                                      );
                                                                      setState(() {
                                                                        futureAttrList =
                                                                            getAttributesFromApi(
                                                                                token:
                                                                                    globals.token);
                                                                      });
                                                                      //await attributeProvider.getAttributeList(futureAttrList);
                                                                      if (!mounted) {
                                                                        return;
                                                                      }
                                                                      ScaffoldMessenger
                                                                          .of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(
                                                                            snackBar);
                                                                    } else {
                                                                      final snackBar =
                                                                          SnackBar(
                                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                                        elevation: 0,
                                                                        duration: const Duration(
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
                                                                          title:
                                                                              'Error!',
                                                                          message:
                                                                              "Something went wrong",
                                                                          contentType:
                                                                              ContentType
                                                                                  .failure,
                                                                        ),
                                                                      );
                                                                      if (!mounted) {
                                                                        return;
                                                                      }
                                                                      ScaffoldMessenger
                                                                          .of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(
                                                                            snackBar);
                                                                    }
                                                                    //setState(() {});
                                                                  },
                                                                  child: const Icon(
                                                                    Icons.delete,
                                                                    color: Color(
                                                                        0xffA00000),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset:
                                    const Offset(0, 4), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Add option',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    openAddAttrOptionDialog();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.0, vertical: 12.0),
                                      child: Text(
                                        'Add option',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                            'S.no',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Text(
                                            'Attribute',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          )),
                                      Expanded(
                                          flex: 5,
                                          child: Text(
                                            'Option name',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          )),
                                      Expanded(
                                          flex: 8,
                                          child: Text(
                                            'Option value',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 14.0),
                                  child: SingleChildScrollView(
                                    child: FutureBuilder(
                                        future: futureAttrOptionsList,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            dynamic data = snapshot.data;
                                            return SizedBox(
                                              height: 120,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: data.length,
                                                  itemBuilder: (context, index) {
                                                    return Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            (index + 1).toString(),
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
                                                            data[index]["attr_id"].toString(),
                                                            style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 6,
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
                                                          flex: 7,
                                                          child: Text(
                                                            data[index]["media"] ??
                                                                "no media",
                                                            style: const TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 15.0,
                                                                fontWeight:
                                                                    FontWeight.w600),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    openAttrOptionEditDialog(
                                                                        attrId: data[
                                                                                index]
                                                                            [
                                                                            "attr_id"],
                                                                        optionId: data[
                                                                                    index]
                                                                                ["id"]
                                                                            .toString());
                                                                  },
                                                                  child: const Icon(
                                                                    Icons.edit,
                                                                    color: Color(
                                                                        0xffA00000),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () async {
                                                                    isLoading = true;
                                                                    context
                                                                        .loaderOverlay
                                                                        .show();
                                                                    dynamic response = await deleteOptions(
                                                                            token: globals
                                                                                .token,
                                                                            attrId: data[index]
                                                                                    [
                                                                                    "attr_id"]
                                                                                .toString(),
                                                                            optId: data[index]
                                                                                    [
                                                                                    "id"]
                                                                                .toString())
                                                                        .whenComplete(
                                                                            () => isLoading =
                                                                                false);
                                                                    if (isLoading ==
                                                                        false) {
                                                                      context
                                                                          .loaderOverlay
                                                                          .hide();
                                                                    }
                                                                    if (response !=
                                                                        null) {
                                                                      final snackBar =
                                                                          SnackBar(
                                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                                        elevation: 0,
                                                                        duration: const Duration(
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
                                                                          title:
                                                                              'Success!',
                                                                          message:
                                                                              response,

                                                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                                                          contentType:
                                                                              ContentType
                                                                                  .success,
                                                                        ),
                                                                      );
                                                                      setState(() {
                                                                        futureAttrOptionsList =
                                                                            getAllOptions(
                                                                          token: globals
                                                                              .token,
                                                                        );
                                                                      });
                                                                      if (!mounted) {
                                                                        return;
                                                                      }
                                                                      ScaffoldMessenger
                                                                          .of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(
                                                                            snackBar);
                                                                    } else {
                                                                      final snackBar =
                                                                          SnackBar(
                                                                        /// need to set following properties for best effect of awesome_snackbar_content
                                                                        elevation: 0,
                                                                        duration: const Duration(
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
                                                                          title:
                                                                              'Error!',
                                                                          message:
                                                                              "Something went wrong",
                                                                          contentType:
                                                                              ContentType
                                                                                  .failure,
                                                                        ),
                                                                      );
                                                                      if (!mounted) {
                                                                        return;
                                                                      }
                                                                      ScaffoldMessenger
                                                                          .of(context)
                                                                        ..hideCurrentSnackBar()
                                                                        ..showSnackBar(
                                                                            snackBar);
                                                                    }
                                                                    // setState(() {
                                                                    //   futureAttrList =
                                                                    //       getAttributesFromApi(
                                                                    //           token:
                                                                    //           globals.token,
                                                                    //       );
                                                                    // });
                                                                  },
                                                                  child: const Icon(
                                                                    Icons.delete,
                                                                    color: Color(
                                                                        0xffA00000),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openAddAttrDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Add Attribute'),
                  content: SingleChildScrollView(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller:
                            nameAttributeTextEditingController,
                            decoration:
                            const InputDecoration(
                                border:
                                InputBorder.none,
                                labelText: 'Name',
                                hintText:
                                'Attribute Name'),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey),
                                borderRadius:
                                BorderRadius.circular(
                                    10.0)),
                            child: Padding(
                              padding:
                              const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0),
                              child: DropdownButton(
                                  underline: Container(),
                                  value: selectedItem,
                                  icon: const Expanded(
                                    child: Align(
                                      alignment:
                                      FractionalOffset
                                          .centerRight,
                                      child: Icon(
                                        Icons
                                            .arrow_drop_down,
                                        color:
                                        Colors.grey,
                                      ),
                                    ),
                                  ),
                                  items: items
                                      .map((String item) {
                                    return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item.toString(),
                                          style:
                                          const TextStyle(
                                            fontSize:
                                            16.0,
                                            color: Colors
                                                .grey,
                                          ),
                                        ));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedItem =
                                      newValue!
                                      as String?;
                                    });
                                  }),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  10.0
                              ),
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 2.0),
                              child: TextButton(
                                onPressed:() async {
                                  dynamic response =
                                  await createAttribute(
                                    token: globals.token,
                                    name:
                                    nameAttributeTextEditingController
                                        .text,
                                    type: selectedItem
                                        .toString(),
                                  ).whenComplete(() =>
                                  isLoading = false);
                                  if (!isLoading) {
                                    context.loaderOverlay
                                        .hide();
                                  }
                                  if (response != null) {
                                    final snackBar = SnackBar(
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
                                      Colors.transparent,
                                      content:
                                      AwesomeSnackbarContent(
                                        title: 'Success!',
                                        message: response
                                            .toString(),

                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType:
                                        ContentType
                                            .success,
                                      ),
                                    );
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(
                                        context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                          snackBar);
                                    Navigator.pop(
                                      context,
                                    );
                                  } else {
                                    final snackBar = SnackBar(
                                      /// need to set following properties for best effect of awesome_snackbar_content
                                      elevation: 0,
                                      behavior:
                                      SnackBarBehavior
                                          .floating,
                                      backgroundColor:
                                      Colors.transparent,
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
                                  setState(() {
                                    futureAttrList = getAttributesFromApi(token: globals.token);
                                  });
                                },
                                style: ButtonStyle(
                                  padding:
                                  MaterialStateProperty
                                      .all(
                                      const EdgeInsets
                                          .all(0)),
                                  elevation:
                                  MaterialStateProperty
                                      .all(1.0),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              8))),
                                  backgroundColor:
                                  MaterialStateProperty
                                      .all(
                                    const Color(0xffA00000),
                                  ),
                                  shadowColor:
                                  MaterialStateProperty
                                      .all(Theme.of(
                                      context)
                                      .colorScheme
                                      .onSurface),
                                ),
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //actions: const <Widget>[],
                );
              });
        });
  }

  void openAttrEditDialog({required attrId}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Attribute'),
              content: SingleChildScrollView(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: nameAttributeTextEditingController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Name',
                            hintText: 'Attribute Name'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: DropdownButton(
                              underline: Container(),
                              value: selectedItem,
                              icon: const Expanded(
                                child: Align(
                                  alignment: FractionalOffset.centerRight,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              items: items.map((String item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item.toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedItem = newValue! as String?;
                                });
                              }),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 2.0
                          ),
                          child: TextButton(
                            onPressed: () async {
                              dynamic response = await updateAttribute(
                                token: globals.token,
                                name: nameAttributeTextEditingController.text,
                                type: selectedItem.toString(),
                                id: attrId,
                              ).whenComplete(() => isLoading = false);
                              if (!isLoading) {
                                context.loaderOverlay.hide();
                              }
                              if (response != null) {
                                setState(() {
                                  futureAttrList = getAttributesFromApi(
                                    token: globals.token,
                                  );
                                });
                                final snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  duration: const Duration(milliseconds: 3000),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Success!',
                                    message: response.toString(),

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.success,
                                  ),
                                );
                                if (!mounted) return;
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                                Navigator.pop(
                                  context,
                                );
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
                            },
                            style: ButtonStyle(
                              padding:
                              MaterialStateProperty
                                  .all(
                                  const EdgeInsets
                                      .all(0)),
                              elevation:
                              MaterialStateProperty
                                  .all(1.0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          8))),
                              backgroundColor:
                              MaterialStateProperty
                                  .all(
                                const Color(0xffA00000),
                              ),
                              shadowColor:
                              MaterialStateProperty
                                  .all(Theme.of(
                                  context)
                                  .colorScheme
                                  .onSurface),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //actions: const <Widget>[],
            );
          });
        });
  }

  void openAddAttrOptionDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            // builder: null,
              builder: (context, setState) {
                return AlertDialog(
                  title: const Text('Add Option'),
                  content: SingleChildScrollView(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey),
                                borderRadius:
                                BorderRadius.circular(
                                    10.0)),
                            child: Padding(
                              padding:
                              const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0),
                              child: DropdownButton(
                                  underline: Container(),
                                  value: selectedItem,
                                  icon: const Expanded(
                                    child: Align(
                                      alignment:
                                      FractionalOffset
                                          .centerRight,
                                      child: Icon(
                                        Icons
                                            .arrow_drop_down,
                                        color:
                                        Colors.grey,
                                      ),
                                    ),
                                  ),
                                  items: items
                                      .map((String item) {
                                    return DropdownMenuItem(
                                        value: item,
                                        child: Text(
                                          item.toString(),
                                          style:
                                          const TextStyle(
                                            fontSize:
                                            16.0,
                                            color: Colors
                                                .grey,
                                          ),
                                        ));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedItem =
                                      newValue!
                                      as String?;
                                      if (selectedItem ==
                                          "custom" ||
                                          selectedItem ==
                                              "size") {
                                        setState(() {
                                          showColor =
                                          false;
                                        });
                                      } else if (selectedItem ==
                                          "color") {
                                        setState(() {
                                          showColor =
                                          true;
                                        });
                                      }
                                    });
                                  }),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                                height: 50.0,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                        Colors.grey),
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10.0)),
                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .only(
                                      left: 10.0,
                                      right: 10.0),
                                  child: DropdownButton<
                                      String>(
                                    value:
                                    selectedAttributeId,
                                    icon: const Expanded(
                                      child: Align(
                                        alignment:
                                        FractionalOffset
                                            .centerRight,
                                        child: Icon(
                                          Icons
                                              .arrow_drop_down,
                                          color:
                                          Colors.grey,
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) =>
                                        setState(() =>
                                        selectedAttributeId =
                                            value
                                                .toString()),
                                    iconEnabledColor: red,
                                    borderRadius:
                                    BorderRadius
                                        .circular(10),
                                    isExpanded: true,
                                    underline:
                                    const SizedBox
                                        .shrink(),
                                    style: TextStyle(
                                        color: Colors.grey
                                            .shade700),
                                    items: attrDdList
                                        .map((val) => DropdownMenuItem<
                                        String>(
                                        value: val[
                                        "id"]
                                            .toString(),
                                        child: Text(
                                            val["name"] ??
                                                "")))
                                        .toList(),
                                  ),
                                ))),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 50.0,
                            child: TextFormField(
                              validator: (val) => val ==
                                  null ||
                                  val.isEmpty
                                  ? "This field is required"
                                  : null,
                              onChanged: (val) =>
                              attributeOptionName =
                                  val,
                              decoration: InputDecoration(
                                border:
                                OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(10.0),
                                ),
                                hintText:
                                'Enter Name Here',
                                labelText:
                                'Enter Name Here',
                                labelStyle:
                                const TextStyle(
                                  color: Colors.grey,
                                ),
                                hintStyle:
                                const TextStyle(
                                  color:
                                  Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: showColor,
                          child: Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 50.0,
                              child: TextFormField(
                                controller:
                                colorHexTextController,
                                readOnly: true,
                                onTap: () {
                                  showDialog(
                                    builder: (context) =>
                                        AlertDialog(
                                          title: const Text(
                                              'Pick a color!'),
                                          content:
                                          SingleChildScrollView(
                                            child:
                                            ColorPicker(
                                              pickerColor:
                                              pickerColors,
                                              onColorChanged:
                                              changeColor,
                                            ),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: const Text(
                                                  'Got it'),
                                              onPressed: () {
                                                setState(() =>
                                                currentColors =
                                                    pickerColors);
                                                hex =
                                                '#${currentColors.value.toRadixString(16)}';
                                                colorHexTextController
                                                    .text =
                                                    hex.toString();
                                                Navigator.of(
                                                    context)
                                                    .pop();
                                              },
                                            ),
                                          ],
                                        ),
                                    context: context,
                                  );
                                },
                                validator: (val) => val ==
                                    null ||
                                    val.isEmpty
                                    ? "This field is required"
                                    : null,
                                decoration:
                                InputDecoration(
                                  border:
                                  OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                        10.0),
                                  ),
                                  hintText:
                                  'Select Color Here',
                                  labelText:
                                  'Select Color Here',
                                  labelStyle:
                                  const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  hintStyle:
                                  const TextStyle(
                                    color: Colors
                                        .transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(
                                  10.0),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                isLoading = true;
                                context.loaderOverlay
                                    .show();
                                dynamic response =
                                await createOptions(
                                    token: globals
                                        .token,
                                    name:
                                    attributeOptionName,
                                    attrId:
                                    selectedAttributeId,
                                    media: hex)
                                    .whenComplete(() =>
                                isLoading =
                                false);
                                if (isLoading == false) {
                                  context.loaderOverlay
                                      .hide();
                                }
                                if (response != null) {
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
                                    futureAttrOptionsList =
                                        getAllOptions(
                                            token: globals
                                                .token);
                                    Navigator.pop(context);
                                    if (!mounted) {
                                      return;
                                    }
                                    ScaffoldMessenger.of(
                                        context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(
                                          snackBar);
                                  });
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
                                  // Navigator.pop(context);
                                  if (!mounted) {
                                    return;
                                  }
                                  ScaffoldMessenger.of(
                                      context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                        snackBar);
                                }

                                attrNameTextController
                                    .clear();
                              },
                              style: ButtonStyle(
                                padding:
                                MaterialStateProperty
                                    .all(
                                    const EdgeInsets
                                        .all(0)),
                                elevation:
                                MaterialStateProperty
                                    .all(1.0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            8))),
                                backgroundColor:
                                MaterialStateProperty
                                    .all(
                                  const Color(0xffA00000),
                                ),
                                shadowColor:
                                MaterialStateProperty
                                    .all(Theme.of(
                                    context)
                                    .colorScheme
                                    .onSurface),
                              ),
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // actions: const <Widget>[],
                );
              });
        });
  }

  void openAttrOptionEditDialog({required attrId, required optionId}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Option'),
              content: SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: DropdownButton(
                              underline: Container(),
                              value: selectedItem,
                              icon: const Expanded(
                                child: Align(
                                  alignment: FractionalOffset.centerRight,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              items: items.map((String item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item.toString(),
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                      ),
                                    ));
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedItem = newValue! as String?;
                                  if (selectedItem == "custom" ||
                                      selectedItem == "size") {
                                    setState(() {
                                      showColor = false;
                                    });
                                  } else if (selectedItem == "color") {
                                    setState(() {
                                      showColor = true;
                                    });
                                  }
                                });
                              }),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: DropdownButton<String>(
                                value: selectedAttributeId,
                                icon: const Expanded(
                                  child: Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                onChanged: (value) => setState(() =>
                                    selectedAttributeId = value.toString()),
                                iconEnabledColor: red,
                                borderRadius: BorderRadius.circular(10),
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
                                style: TextStyle(color: Colors.grey.shade700),
                                items: attrDdList
                                    .map((val) => DropdownMenuItem<String>(
                                        value: val["id"].toString(),
                                        child: Text(val["name"] ?? "")))
                                    .toList(),
                              ),
                            ))),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 50.0,
                        child: TextFormField(
                          validator: (val) => val == null || val.isEmpty
                              ? "This field is required"
                              : null,
                          onChanged: (val) => attributeOptionName = val,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Enter Name Here',
                            labelText: 'Enter Name Here',
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showColor,
                      child: Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 50.0,
                          child: TextFormField(
                            controller: colorHexTextController,
                            readOnly: true,
                            onTap: () {
                              showDialog(
                                builder: (context) => AlertDialog(
                                  title: const Text('Pick a color!'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: pickerColors,
                                      onColorChanged: changeColor,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('Got it'),
                                      onPressed: () {
                                        setState(
                                            () => currentColors = pickerColors);
                                        hex =
                                            '#${currentColors.value.toRadixString(16)}';
                                        colorHexTextController.text =
                                            hex.toString();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                                context: context,
                              );
                            },
                            validator: (val) => val == null || val.isEmpty
                                ? "This field is required"
                                : null,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              hintText: 'Select Color Here',
                              labelText: 'Select Color Here',
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              hintStyle: const TextStyle(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            isLoading = true;
                            context.loaderOverlay.show();
                            dynamic response = await updateOptions(
                              token: globals.token,
                              name: attributeOptionName,
                              attrId: selectedAttributeId,
                              media: hex,
                              optionId: optionId,
                            ).whenComplete(() => isLoading = false);
                            if (isLoading == false) {
                              context.loaderOverlay.hide();
                            }
                            if (response != null) {
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
                                futureAttrOptionsList =
                                    getAllOptions(token: globals.token);
                                if (!mounted) {
                                  return;
                                }
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              });
                            } else {
                              final snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                duration: const Duration(milliseconds: 3000),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error!',
                                  message: "Something went wrong",

                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType: ContentType.failure,
                                ),
                              );
                              if (!mounted) {
                                return;
                              }
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            }

                            attrNameTextController.clear();
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(0)),
                            elevation: MaterialStateProperty.all(1.0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0xffA00000),
                            ),
                            shadowColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.onSurface),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: const <Widget>[],
            );
          });
        });
  }

}