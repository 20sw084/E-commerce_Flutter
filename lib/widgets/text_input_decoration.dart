import 'package:flutter/material.dart';

InputDecoration textInputDecoration({required String label, IconData? prefixIcon, IconData? suffixIcon, VoidCallback? suffixOnTap}) =>
    InputDecoration(
        fillColor: const Color(0xffF0F0F0),
        focusColor: const Color(0xff9E9E9E),
        iconColor: const Color(0xffaaaaaa),
        filled: true,
        prefixIconColor: const Color(0xff9E9E9E),
        suffixIconColor: const Color(0xff9E9E9E),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : const SizedBox.shrink(),
        prefixIconConstraints:
            prefixIcon != null ? const BoxConstraints(minHeight: 48, minWidth: 48) : const BoxConstraints(minHeight: 24, minWidth: 24),
        suffixIcon: suffixIcon != null ? IconButton(onPressed: suffixOnTap, icon: Icon(suffixIcon)) : const SizedBox.shrink(),
        suffixIconConstraints:
            suffixIcon != null ? const BoxConstraints(minHeight: 48, minWidth: 48) : const BoxConstraints(minHeight: 24, minWidth: 24),
        labelStyle: const TextStyle(fontWeight: FontWeight.w400, color: Color(0xff808080)),
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 1, color: Color(0xffF0F0F0)), borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2, color: Color(0xff9E9E9E)), borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        labelText: label);
