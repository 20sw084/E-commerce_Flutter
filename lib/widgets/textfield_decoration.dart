import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

textFieldDecoration({
  required String label,
  required IconData prefixIcon,
  Widget suffixIcon = const SizedBox.shrink(),
}) =>
    InputDecoration(
        prefixIcon: Icon(prefixIcon, color: grey_2, size: 18),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0, color: grey_5), borderRadius: BorderRadius.circular(8.0)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: grey_2), borderRadius: BorderRadius.circular(8.0)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0, color: grey_5), borderRadius: BorderRadius.circular(8.0)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: red_1), borderRadius: BorderRadius.circular(8.0)),
        filled: true,
        labelStyle: GoogleFonts.poppins(fontSize: 14, color: grey_2.withOpacity(0.75)),
        floatingLabelStyle: TextStyle(color: grey_1),
        labelText: label,
        fillColor: grey_5);

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
    labelText: 'label',
    fillColor: grey_5);
