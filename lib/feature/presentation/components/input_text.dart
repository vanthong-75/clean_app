import 'package:flutter/Material.dart';


class InputText {
    static Widget inputText(String textHolder, Widget labelIcon){
        return TextField(
            decoration: InputDecoration(
                hintText: textHolder,
                prefixIcon: labelIcon,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)
                )
            ),
        );
    }
}