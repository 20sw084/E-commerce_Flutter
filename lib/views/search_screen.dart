import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../widgets/product_list_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: white,
      body: SafeArea(
          child: Column(children: [
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.arrow_back_ios_new_outlined, color: grey_1)),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                    autofocus: true,
                    decoration: textfieldStyle.copyWith(
                        prefixIcon: IconButton(onPressed: () {}, icon: const Icon(EvaIcons.search), color: grey_2.withOpacity(0.7)),
                        suffixIcon: IconButton(onPressed: () {}, icon: const Icon(EvaIcons.options2Outline), color: red_2, iconSize: 20))),
              )
            ])),
        const SizedBox(height: 16),
        const Expanded(child: ProductListView()),
        const SizedBox(height: 16)
      ])));

  InputDecoration textfieldStyle = InputDecoration(
      prefixIconColor: grey_2,
      suffixIconColor: grey_2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      border: OutlineInputBorder(borderSide: BorderSide(width: 0, color: grey_5), borderRadius: BorderRadius.circular(8.0)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: grey_2), borderRadius: BorderRadius.circular(8.0)),
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: grey_5), borderRadius: BorderRadius.circular(8.0)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: red_1), borderRadius: BorderRadius.circular(8.0)),
      filled: true,
      labelStyle: GoogleFonts.poppins(fontSize: 14, color: grey_2.withOpacity(0.75)),
      floatingLabelStyle: TextStyle(color: grey_1),
      labelText: 'Search',
      fillColor: grey_5);
}
