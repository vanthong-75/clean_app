import 'package:flutter/Material.dart';

class InputText {
  static Widget inputText(
    String textHolder,
    Widget labelIcon,
    TextEditingController? value,
  ) {
    return TextField(
      controller: value,
      decoration: InputDecoration(
        hintText: textHolder,
        prefixIcon: labelIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
