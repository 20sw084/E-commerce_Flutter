import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isSearchVisible;
  const CustomAppBar({Key? key, required this.title, this.isSearchVisible = true}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
      elevation: 0,
      backgroundColor: white,
      foregroundColor: black,
      actions: isSearchVisible ? [IconButton(onPressed: () {}, icon: const Icon(EvaIcons.searchOutline))] : [],
      title: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)));
}
